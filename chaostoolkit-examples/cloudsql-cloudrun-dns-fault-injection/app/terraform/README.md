<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.8.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.1 |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.ip-address-psc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.sshtoinstance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.toxiproxyegress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.toxiproxyingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_instance.proxyclient](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance.proxyserver](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.vpc-consumer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_network.vpc-producer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.consumer-subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.producer-subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_dns_managed_zone.pscsql-zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.frontend](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_project_iam_member.project](https://registry.terraform.io/providers/hashicorp/google/5.8.0/docs/resources/google_project_iam)| resource |
| [google_project_service.gcp_services_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.chaos_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_sql_database_instance.cloudsql](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_vpc_access_connector.vpccon](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vpc_access_connector) | resource |
| [local_file.variable_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [google_sql_database_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/sql_database_instance) | data source |
| [local exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec) | |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_consumer_subnet_cidr"></a> [consumer\_subnet\_cidr](#input\_consumer\_subnet\_cidr) | CIDR range for consumer subnet | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | database password | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | databse user | `string` | n/a | yes |
| <a name="input_producer_subnet_cidr"></a> [producer\_subnet\_cidr](#input\_producer\_subnet\_cidr) | CIDR range for producer subnet | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID for project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region in project | `string` | n/a | yes |
| <a name="input_static_ip_address"></a> [static\_ip\_address](#input\_static\_ip\_address) | static IP address for PSC endpoint | `string` | n/a | yes |
| <a name="input_tf_service_account"></a> [tf\_service\_account](#input\_tf\_service\_account) | Service account for creating terraform resources for the L7 ILB Chaos experiment | `string` | n/a | yes |
| <a name="input_vpcconnrange"></a> [vpcconnrange](#input\_vpcconnrange) | CIDR for vpc connector | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone in project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chaos_sql_service_account"></a> [chaos\_sql\_service\_account](#output\_chaos\_sql\_service\_account) | The service account used for running the experiment |
| <a name="output_dns_name_sql"></a> [dns\_name\_sql](#output\_dns\_name\_sql) | the DNS connection URL of the cloud SQL instance |
| <a name="output_sql_name"></a> [sql\_name](#output\_sql\_name) | Name of the cloud SQL instance |
<!-- END_TF_DOCS -->
