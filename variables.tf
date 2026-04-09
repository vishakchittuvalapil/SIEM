############################
# Variables
############################
variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaakxcj247rl2tyoc6bsmexmcnku6x6ze4p55lqfobmww2rnrjbksiq"
}
variable "user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaauul6bfchwqfnqaxkegtuhu5xsut7xkpdd3qytmkytbfv27n2znja"
}
variable "fingerprint" {
  default = "a7:31:0a:70:ec:e2:77:51:00:bb:fd:c7:8f:73:80:f6"
}
variable "private_key_path" {
  default = "/Users/vchittuv/.oci/terraform.pem"
}
variable "region" {
  default = "us-ashburn-1"
}

variable "compartment_id" {
  default = "ocid1.compartment.oc1..aaaaaaaapjdzahspbgldg4d7vwtty47hywkaqu3372jj2cytb7chlaiqmgha"
}


variable "stream_pool_name" {
  default = "vishak-private-stream-pool"
}

variable "stream_name" {
  default = "vishak-logging-stream"
}

variable "connector_name" {
  default = "vishak-logging-to-stream-connector"
}

variable "private_subnet_id" {
  default = "ocid1.subnet.oc1.iad.aaaaaaaahteqatnfgjd2nb4355qylb3nhx3scxtbg4krekhhcqz2knx73s5a"
}

variable "private_endpoint_nsg_ids" {
  type    = list(string)
  default = []
}

variable "stream_partitions" {
  type    = number
  default = 1
}

variable "retention_in_hours" {
  type    = number
  default = 24
}