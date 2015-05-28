require "fastlane/actions/emlauncher/version"

module Fastlane
  module Actions
    module SharedValues
    end

    class EmlauncherAction < Action
      SERVICE_NAME = 'EMLauncher'

      def self.run(options)
        Helper.log.info "Starting with ipa upload to #{SERVICE_NAME}... this could take some time ⏳".green

        return if Helper.test?
        Helper.log.info "test passed".green

        command = <<-EOL
curl #{options[:api_url]} \
  -F api_key=#{options[:api_token]} \
  -F file=@#{options[:ipa]} \
  -F title='#{options[:title]}' \
  -F description='#{options[:message]}' \
  -F tags='#{options[:tags]}'
        EOL

        if system(command)
          Helper.log.info "Build successfully uploaded to #{SERVICE_NAME}!".green
        else
          raise "Error when trying to upload ipa to #{SERVICE_NAME}".red
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Upload a new build to EMLauncher"
      end

      def self.available_options
        # Below a few examples
        options = [
          {
              key: :api_url,
              env_name: "FL_EMLAUNCHER_API_URL",
              description: "API URL for EmlauncherAction",
          },
          {
              key: :api_token,
              env_name: "FL_EMLAUNCHER_API_TOKEN", # The name of the environment variable
              description: "API Token for EmlauncherAction", # a short description of this parameter
              verify_block: Proc.new do |value|
                raise "No API token for EmlauncherAction given, pass using `api_token: 'token'`".red unless (value and not value.empty?)
              end,
          },
          {
              key: :ipa,
              env_name: "FL_EMLAUNCHER_IPA_PATH",
              description: "Path to your IPA file. Optional if you use the `ipa` or `xcodebuild` action",
              default_value: Actions.lane_context[SharedValues::IPA_OUTPUT_PATH],
              verify_block: Proc.new do |value|
                raise "Couldn't find ipa file at path '#{value}'".red unless File.exists?(value)
              end,
          },
          {
              key: :title,
              env_name: "FL_EMLAUNCHER_TITLE",
              description: "title",
              default_value: "new build",
          },
          {
              key: :message,
              env_name: "FL_EMLAUNCHER_MESSAGE",
              description: "Release Notes",
              default_value: "No changelog provided",
          },
          {
              key: :tags,
              env_name: "FL_EMLAUNCHER_TAGS",
              description: "tags",
              default_value: "",
          },
        ]

        options.map {|option|
          FastlaneCore::ConfigItem.new(option)
        }
      end

      def self.output
        []
      end

      def self.author
        'keqh'
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
