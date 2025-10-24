.[] | "    {
      name = \"" + .name + "\"
      description = \"" + (.description // "") + "\"
      visibility = \"" + (.visibility | ascii_downcase) + "\"
      archive_on_destroy = false
      archived = " + (.isArchived | tostring) + "
      is_template = " + (.isTemplate | tostring) + "
      topics = [\"terraform\", \"github\", \"example\"]
      has_issues = true
    },"
