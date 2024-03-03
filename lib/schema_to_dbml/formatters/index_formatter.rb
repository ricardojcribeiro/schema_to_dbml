# frozen_string_literal: true

require_relative '../helpers/constants'

module Formatters
  module IndexFormatter
    include Helpers::Constants

    def format_index(columns, index_name, unique)
      formatted_columns = format_index_columns(columns)
      formatted_settings = format_index_settings(unique)
      formatted_name = "name: '#{index_name}'"
      formatted_values = [formatted_settings, formatted_name].compact.join(', ')

      "#{TAB * 2}(#{formatted_columns}) [#{formatted_values}]"
    end

    private

    def format_index_columns(columns)
      columns.gsub('"', '').split(', ').join(', ')
    end

    def format_index_settings(unique)
      # There are other possible settings for indexes
      # but for now we will only add unique
      # https://dbml.dbdiagram.io/docs/#index-definition
      return unless unique

      'unique'
    end
  end
end
