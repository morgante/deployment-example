#
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package templates.gcp.GCPEnforceLabelConstraintV1

import data.validator.gcp.lib as lib

deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	lib.get_constraint_params(constraint, params)
	asset := input.asset

	# test if we have a valid resource
	resource := asset.resource.data

	mandatory_label := params.mandatory_labels[_]
	label_value_pattern := mandatory_label[label_key]

	default_resource_types := {
		"cloudresourcemanager.googleapis.com/Project",
		"storage.googleapis.com/Bucket",
		"compute.googleapis.com/Instance",
		"compute.googleapis.com/Image",
		"compute.googleapis.com/Disk",
		"compute.googleapis.com/Snapshot",
		"google.bigtable.Instance",
		"sqladmin.googleapis.com/Instance",
		"dataproc.googleapis.com/Job",
		"dataproc.googleapis.com/Cluster",
	}

	non_standard_types := {"sqladmin.googleapis.com/Instance"}

	resource_types_to_scan := lib.get_default(params, "resource_types_to_scan", default_resource_types)

	# test if resource needs to be scanned
	resource_types_to_scan[_] == asset.asset_type

	not label_is_valid(label_key, label_value_pattern, asset, non_standard_types)

	message := sprintf("%v's label is in violation.", [asset.name])
	metadata := {"resource": asset.name, "label_in_violation": label_key}
}

# check if label exists and if its value matches the pattern passed as a parameter for all resources to scan
label_is_valid(label_key, label_value_pattern, asset, non_standard_types) {
	# retrieve the right values from asset
	resource_labels := get_labels(asset, non_standard_types)

	# test if label exists in asset
	resource_labels[label_key]

	# test if label value matches pattern passed as a parameter 
re_match(	label_value_pattern, resource_labels[label_key])
}

# get_labels for cloudsql instances
get_labels(asset, non_standard_types) = resource_labels {
	# check if we have a non-standard type 
	asset.asset_type == non_standard_types[_]
	asset.asset_type == "sqladmin.googleapis.com/Instance"
	resource := asset.resource.data.settings
	resource_labels := lib.get_default(resource, "userLabels", {})
}

# get_labels for most resources (not non-standard resources)
# this defaults to asset.resource.data.labels
get_labels(asset, non_standard_types) = resource_labels {
	asset_type := asset.asset_type
	not non_standard_types[asset_type]
	resource := asset.resource.data
	resource_labels := lib.get_default(resource, "labels", {})
}
