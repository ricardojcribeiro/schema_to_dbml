# frozen_string_literal: true

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

    ref += " [delete: #{on_delete}]" if on_delete
    ref
  end

  private

  def default_foreign_key_column(to_table)
    "#{singularize(to_table)}_id"
  end

  def generate_reference_name(from_table, to_table, column)
    ref_name = "fk_rails_#{from_table}_#{to_table}"
    ref_name += "_#{column}" if column != default_foreign_key_column(to_table)
    ref_name
  end

  def build_reference_string(ref_name, from_table, column, to_table)
    "Ref #{ref_name}:#{from_table}.#{column} - #{to_table}.id"
  end

  # Singularizes a word
  #
  # @param word [String] the word to singularize
  #
  # @return [String] the singularized word
  def singularize(word)
    word.sub(/(?:([^aeiouy])y|s)$/, '\1').sub(/ies$/, 'y')
  end
end
