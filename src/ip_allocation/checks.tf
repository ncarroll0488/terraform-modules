resource "terraform_data" "check_duplicate_tags" {
  lifecycle {
    postcondition {
      condition     = length(distinct(local.all_cidr_configs)) == length(local.all_cidr_configs)
      error_message = "A duplicate set of tags was found"
    }
  }
}

resource "terraform_data" "check_duplicate_cidrs" {
  lifecycle {
    postcondition {
      condition     = max(values(local.cidr_counts)...) == 1 || var.allow_duplicate_cidrs
      error_message = format("Duplicate CIDRs found: %s", jsonencode(local.cidr_counts))
    }
  }
}

data "external" "overlap" {
  program     = flatten([["python3", "find_ip_overlaps.py"], var.json_documents])
  working_dir = abspath(dirname("."))
  lifecycle {
    postcondition {
      condition     = length(self.result["overlaps"]) == 0 || var.allow_overlapping_cidrs
      error_message = format("Overlapping CIDRs found: %s", jsonencode(self.result["overlaps"]))
    }
  }
}
