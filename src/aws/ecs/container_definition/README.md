## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.66.1 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.66.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_log\_group\_kms\_key\_id | If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html) | `string` | `null` | no |
| cloudwatch\_log\_group\_name | Custom name of CloudWatch log group for a service associated with the container definition | `string` | `null` | no |
| cloudwatch\_log\_group\_retention\_in\_days | Number of days to retain log events. Default is 30 days | `number` | `30` | no |
| cloudwatch\_log\_group\_use\_name\_prefix | Determines whether the log group name should be used as a prefix | `bool` | `false` | no |
| command | The command that's passed to the container | `list(string)` | `[]` | no |
| cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of `cpu` of all containers in a task will need to be lower than the task-level cpu value | `number` | `null` | no |
| create\_cloudwatch\_log\_group | Determines whether a log group is created by this module. If not, AWS will automatically create one if logging is enabled | `bool` | `true` | no |
| dependencies | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | <pre>list(object({<br>    condition     = string<br>    containerName = string<br>  }))</pre> | `[]` | no |
| disable\_networking | When this parameter is true, networking is disabled within the container | `bool` | `null` | no |
| dns\_search\_domains | Container DNS search domains. A list of DNS search domains that are presented to the container | `list(string)` | `[]` | no |
| dns\_servers | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | `list(string)` | `[]` | no |
| docker\_labels | A key/value map of labels to add to the container | `map(string)` | `{}` | no |
| docker\_security\_options | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. This field isn't valid for containers in tasks using the Fargate launch type | `list(string)` | `[]` | no |
| enable\_cloudwatch\_logging | Determines whether CloudWatch logging is configured for this container definition. Set to `false` to use other logging drivers | `bool` | `true` | no |
| enable\_execute\_command | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| entrypoint | The entry point that is passed to the container | `list(string)` | `[]` | no |
| environment | The environment variables to pass to the container | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| environment\_files | A list of files containing the environment variables to pass to a container | <pre>list(object({<br>    value = string<br>    type  = string<br>  }))</pre> | `[]` | no |
| essential | If the `essential` parameter of a container is marked as `true`, and that container fails or stops for any reason, all other containers that are part of the task are stopped | `bool` | `null` | no |
| extra\_hosts | A list of hostnames and IP address mappings to append to the `/etc/hosts` file on the container | <pre>list(object({<br>    hostname  = string<br>    ipAddress = string<br>  }))</pre> | `[]` | no |
| firelens\_configuration | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more information, see [Custom Log Routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the Amazon Elastic Container Service Developer Guide | `any` | `{}` | no |
| health\_check | The container health check command and associated configuration parameters for the container. See [HealthCheck](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html) | `any` | `{}` | no |
| hostname | The hostname to use for your container | `string` | `null` | no |
| image | The image used to start a container. This string is passed directly to the Docker daemon. By default, images in the Docker Hub registry are available. Other repositories are specified with either `repository-url/image:tag` or `repository-url/image@digest` | `string` | `null` | no |
| interactive | When this parameter is `true`, you can deploy containerized applications that require `stdin` or a `tty` to be allocated | `bool` | `false` | no |
| links | The links parameter allows containers to communicate with each other without the need for port mappings. This parameter is only supported if the network mode of a task definition is `bridge` | `list(string)` | `[]` | no |
| linux\_parameters | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more information see [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html) | `any` | `{}` | no |
| log\_configuration | The log configuration for the container. For more information see [LogConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html) | `any` | `{}` | no |
| memory | The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. The total amount of memory reserved for all containers within a task must be lower than the task `memory` value, if one is specified | `number` | `null` | no |
| memory\_reservation | The soft limit (in MiB) of memory to reserve for the container. When system memory is under heavy contention, Docker attempts to keep the container memory to this soft limit. However, your container can consume more memory when it needs to, up to either the hard limit specified with the `memory` parameter (if applicable), or all of the available memory on the container instance | `number` | `null` | no |
| mount\_points | The mount points for data volumes in your container | `list(any)` | `[]` | no |
| name | The name of a container. If you're linking multiple containers together in a task definition, the name of one container can be entered in the links of another container to connect the containers. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed | `string` | `null` | no |
| operating\_system\_family | The OS family for task | `string` | `"LINUX"` | no |
| port\_mappings | The list of port mappings for the container. Port mappings allow containers to access ports on the host container instance to send or receive traffic. For task definitions that use the awsvpc network mode, only specify the containerPort. The hostPort can be left blank or it must be the same value as the containerPort | `list(any)` | `[]` | no |
| privileged | When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user) | `bool` | `false` | no |
| pseudo\_terminal | When this parameter is true, a `TTY` is allocated | `bool` | `false` | no |
| readonly\_root\_filesystem | When this parameter is true, the container is given read-only access to its root file system | `bool` | `true` | no |
| repository\_credentials | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | `map(string)` | `{}` | no |
| resource\_requirements | The type and amount of a resource to assign to a container. The only supported resource is a GPU | <pre>list(object({<br>    type  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| secrets | The secrets to pass to the container. For more information, see [Specifying Sensitive Data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html) in the Amazon Elastic Container Service Developer Guide | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| service | The name of the service that the container definition is associated with | `string` | `""` | no |
| start\_timeout | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | `number` | `30` | no |
| stop\_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `120` | no |
| system\_controls | A list of namespaced kernel parameters to set in the container | `list(map(string))` | `[]` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| ulimits | A list of ulimits to set in the container. If a ulimit value is specified in a task definition, it overrides the default values set by Docker | <pre>list(object({<br>    hardLimit = number<br>    name      = string<br>    softLimit = number<br>  }))</pre> | `[]` | no |
| user | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group. The default (null) will use the container's configured `USER` directive or root if not set | `string` | `null` | no |
| volumes\_from | Data volumes to mount from another container | `list(any)` | `[]` | no |
| working\_directory | The working directory to run commands inside the container | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_log\_group\_arn | ARN of CloudWatch log group created |
| cloudwatch\_log\_group\_name | Name of CloudWatch log group created |
| container\_definition | Container definition |

Adapted from https://github.com/terraform-aws-modules/terraform-aws-ecs
