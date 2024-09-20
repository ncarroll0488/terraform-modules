import ipaddress
import itertools
import sys
import json

def find_cidr_overlaps (cidrs) :

  # Make network objects using the ipaddress module
  cidr_objects = [ ipaddress.ip_network(cidr) for cidr in cidrs ]

  # Create a cartesian product with depth of 2 (left, and right or l, r) and iterate over them, looking for overlaps
  return [ (str(l), str(r)) for l, r in itertools.combinations(cidr_objects, 2) if l.overlaps(r) ]

def main () :
  # Try to load all files given after the first arg
  json_files = sys.argv[1:]

  # Initialize an empty dict
  cidr_dict = {}

  # Iterate through the json files, updating the dict with their contents. This will cause some silent de-duplication
  # However, if we've made it this far through terraform we either don't have duplicates or aren't concerned with them
  for f in json_files :
    with open(f) as fd :
      cidr_dict.update(json.load(fd))
  overlaps = find_cidr_overlaps(cidr_dict.keys())

  # Terraform is picky about expected results from the script, so the entire result should be one blob
  overlap_string = "\n".join([", ".join(sorted(o)) for o in overlaps])

  print(json.dumps({"overlaps": overlap_string}))

if __name__ == "__main__" :
  main()
