provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

provider "oci" {
  alias            = "home"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

provider "oci" {
  alias            = "secondary_region"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# Private Stream Pool

resource "oci_streaming_stream_pool" "private_pool" {
  compartment_id = var.compartment_id
  name           = var.stream_pool_name

  private_endpoint_settings {
    subnet_id = var.private_subnet_id
    nsg_ids   = var.private_endpoint_nsg_ids
  }
}


# Stream in the private pool

resource "oci_streaming_stream" "log_stream" {
  name               = var.stream_name
  partitions         = var.stream_partitions
  retention_in_hours = var.retention_in_hours
  stream_pool_id     = oci_streaming_stream_pool.private_pool.id
}


# Service Connector Hub
# Audit logs -> Stream
module "service_connectors" {
  source = "github.com/oci-landing-zones/terraform-oci-modules-observability//service-connectors?ref=v0.2.5"

  tenancy_ocid = var.tenancy_ocid

  providers = {
    oci                  = oci
    oci.home             = oci.home
    oci.secondary_region = oci.secondary_region
  }

  service_connectors_configuration = {
    default_compartment_id = var.compartment_id

    service_connectors = {
      AUDIT_TO_STREAM = {
        display_name = var.connector_name
        description  = "Move OCI Audit logs to a private OCI Stream"
        activate     = true

        source = {
          kind = "logging"
          audit_logs = [
            { cmp_id = "ALL" }
          ]
        }

        target = {
          kind           = "streaming"
          stream_id      = oci_streaming_stream.log_stream.id
          compartment_id = var.compartment_id
        }

        policy = {
          name           = "sch-audit-to-stream-policy"
          description    = "Allow Service Connector Hub to push to the stream"
          compartment_id = var.compartment_id
        }
      }
    }
  }
}

#Policy for Service user in OCI to read from Stream

resource "oci_identity_policy" "splunk_policy" {
  compartment_id = var.tenancy_ocid
  name           = "splunk_policy"
  description    = "Allow github actions group to read the stream"

  statements = [
    "Allow group 'vishakdomain'/'github-actions-grp' to use stream-pull in compartment id ${var.compartment_id}"
  ]
}
