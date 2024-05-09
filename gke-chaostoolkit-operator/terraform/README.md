<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.8.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.1 |

## Resources

The below resources will be created through Terraform

| Name | Type |
|------|------|
| [module.gke](hhttps://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest) |module |
| [google_compute_firewall.fw_iap](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.gke-client](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.ilb_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_iam_binding.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.project_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_service.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.chaos_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [local_file.client_startup.sh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compute_ip_address"></a> [compute\_ip\_address](#input\_compute\_ip\_address) | IP address for L7 internal load balancer forwarding rule | `string` | `"10.1.2.23"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy the resources in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which to deploy the resources | `string` | `"us-central1"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | subnetwork CIDR range | `string` | `"10.1.2.0/26"` | no |
| <a name="input_proxy_subnet_cidr"></a> [proxy\_subnet\_cidr](#input\_proxy\_subnet\_cidr) | proxy subnetwork CIDR range for L7 ILB | `string` | `"10.0.1.0/24"` | no |
| <a name="input_tf_service_account"></a> [tf\_service\_account](#input\_tf\_service\_account) | Service account for creating terraform resources for the L7 ILB Chaos experiment | `string` | n/a | yes |
| <a name="input_url_map_name"></a> [url\_map\_name](#input\_url\_map\_name) | Url map name for the L7 ILB | `string` | `"chaos-l7-ilb"` | no |
| <a name="input_url_map_target_name"></a> [url\_map\_target\_name](#input\_url\_map\_target\_name) | The path matcher name for injecting faults | `string` | `"chaos-int-l7-lb-path-matcher"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone in which to deploy the VM | `string` | `"us-central1-a"` | no |

## Outputs

The following output values will be generated after running terraform apply.

| Name | Description |
|------|-------------|
| <a name="output_chaos_service_account"></a> [chaos\_service\_account](#output\_chaos\_service\_account) | n/a |
| <a name="output_client_vm_name"></a> [client\_vm\_name](#output\_client\_vm\_name) | n/a |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_region"></a> [region](#output\_region) | n/a |
| <a name="output_var_url_map_name"></a> [var\_url\_map\_name](#output\_var\_url\_map\_name) | n/a |
| <a name="output_var_url_map_target_name"></a> [var\_url\_map\_target\_name](#output\_var\_url\_map\_target\_name) | n/a |
<!-- END_TF_DOCS -->