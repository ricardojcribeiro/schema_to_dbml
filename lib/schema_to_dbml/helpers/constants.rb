# frozen_string_literal: true

module Helpers
  module Constants
    TAB = '  '

    TABLES_REGEXP = /
      create_table\s+"(?<table_name>\w+)"
      (?:,\s+comment:\s+"(?<comment>.*?)")?
      (?:,\s+force:\s+:cascade)?
      \s+do\s+\|t\|
      \n
      (?<table_attributes>(?:.*?)(?:".*?")*.*?)
      (?<=\n)
      \s+end
    /xm

    COLUMNS_REGEXP = /
      t\.(?<type>\w+)\s+"(?<name>\w+)"
      (?:
        (?:,\s+(?<default>default:[^,\n]+?(?=(?:,\s)|$)))?
        (?:,\s+(?<null>null:\s+\w+))?
        (?:,\s+comment:\s+"(?<comment>[^"\\]*(?:\\.[^"\\]*)*)")?
        (?:,\s+precision:\s+(?<precision>\d+))?
        (?:,\s+array:\s+(?<array>true|false))?
        (?:,\s+limit:\s+(?<limit>\d+))?
      )*
    /x

    INDEXES_REGEXP = /
      t\.index\s+\[(?<columns>[^\]]+)\]
      (?:,\s+name:\s+"(?<name>[^"\\]*(?:\\.[^"\\]*)*)")?
      (?:,\s+unique:\s+(?<unique>true|false))?
    /x

    RELATIONS_REGEXP = /
      add_foreign_key\s+"(?<from_table>\w+)",\s+"(?<to_table>\w+)"
      (?:,\s+column:\s+"(?<column>\w+)")?
      (?:,\s+on_delete:\s+:(?<on_delete>\w+))?
    /x
  end
end
