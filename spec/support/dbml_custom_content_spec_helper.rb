# frozen_string_literal: true

module DbmlCustomContentSpecHelper
  def self.included(base)
    base.extend(ClassMethods)

    base.class_eval do
      let(:default_config_path) { SchemaToDbml::DEFAULT_CONFIG_FILE }
      let(:custom_config_path) { "#{SUPPORT_FILES_PATH}/custom_config_example.yml" }
      let(:load_custom_config) { SchemaToDbml.load_configuration_from_yaml(file_path: custom_config_path) }
      let(:load_default_config) { SchemaToDbml.load_configuration_from_yaml }
      let(:configuration) { SchemaToDbml.configuration }
    end
  end

  module ClassMethods
    def stub_custom_config
      before { load_custom_config }
      rollback_config
    end

    def rollback_config
      after { load_default_config }
    end
  end
end
