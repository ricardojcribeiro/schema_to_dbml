# frozen_string_literal: true

require 'active_support/inflector'

class DbmlRelationsFormatter
  # Formats a database relationship for a DBML file
  #
  # @param from_table [String] the table that has the foreign key
  # @param to_table [String] the table being referenced
  # @param column [String, nil] the name of the foreign key column; defaults to the singularized form of the to_table
  # @param on_delete [String, nil] the delete behavior (e.g., "cascade"); optional
  #
  # @return [String] the formatted relationship string for a DBML file
  def format(from_table:, to_table:, column: nil, on_delete: nil)
    column ||= default_foreign_key_column(to_table)

    ref_name = generate_reference_name(from_table, to_table, column)
    ref = build_reference_string(ref_name, from_table, column, to_table)

    format_on_delete(ref, on_delete)
    ref
  end

  private

  def generate_reference_name(from_table, to_table, column)
    ref_name = "fk_rails_#{from_table}_#{to_table}"
    ref_name << "_#{column}" if column != default_foreign_key_column(to_table)
    ref_name
  end

  def default_foreign_key_column(to_table)
    "#{to_table.singularize}_id"
  end

  def build_reference_string(ref_name, from_table, column, to_table)
    "Ref #{ref_name}:#{from_table}.#{column} - #{to_table}.id"
  end

  def format_on_delete(ref, on_delete)
    return unless on_delete

    on_delete = 'set null' if on_delete == 'nullify'
    ref << " [delete: #{on_delete}]"
  end
end
