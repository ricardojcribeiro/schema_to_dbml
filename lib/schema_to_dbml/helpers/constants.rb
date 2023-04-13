# frozen_string_literal: true

module Helpers
  module Constants
    # rubocop:disable Layout/LineLength
    TABLES_REGEXP = /create_table\s+"(?<table_name>\w+)"(?:,\s+comment:\s+"(?<comment>.*?)")?(?:,\s+force:\s+:cascade)?\s+do\s+\|t\|\n(?<table_content>.*?)end/m

    COLUMNS_REGEXP = /t\.(?<type>\w+)\s+"(?<name>\w+)"(?:,\s+default:\s+(?<default>[^,\s]+))?(?:,\s+(?<null>null:\s+\w+))?(?:,\s+comment:\s+"(?<comment>[^"]+)")?(?:,\s+precision:\s+(?<precision>\d+))?(?:,\s+array:\s+(?<array>true|false))?.*/
    # rubocop:enable Layout/LineLength
  end
end
