data "aws_subnet_ids" "redis_subnets" {
  vpc_id = var.vpc_id
  filter {
    name   = "tag:Tier"
    values = ["data"]       
  }
}
resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.namespace}-cache-subnet"
  subnet_ids = "${data.aws_subnet_ids.redis_subnets.ids}"
}

resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id          = var.cluster_name
  replication_group_description = "${var.cluster_name} Cluster"
  node_type                     = "cache.t2.small"
  port                          = 6379
  parameter_group_name          = "default.redis3.2.cluster.on"
  automatic_failover_enabled    = true
  engine_version                = "3.2"
  subnet_group_name             = "${aws_elasticache_subnet_group.default}""

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 2
  }
}