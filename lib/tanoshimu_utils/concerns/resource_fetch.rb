module TanoshimuUtils
  module Concerns
    module ResourceFetch
      extend ActiveSupport::Concern

      class ResourceNotAttachable < TanoshimuUtils::Error
        def initialize(resource_name)
          super("Resource #{resource_name} not attachable.")
        end
      end

      class_methods do
        def has_resource(resource_name, default_url: '/', expiry: 1.day)
          resource_url = :"#{resource_name}_url"
          db_resource_url = :"db_#{resource_url}?"
          send(:define_method, db_resource_url) do
            @db_resource_url ||= self.class.column_names.include?(resource_url.to_s)
          end
          send(:define_method, resource_url) do
            ensure_fetchable_resource!(resource_name)
            resource_url_for(resource_name, default_url: default_url, expiry: expiry)
          end
          send(:define_method, "#{resource_url}!") do
            attachment = resource_for(resource_name).attachment
            return default_url if attachment.nil?

            if Rails.configuration.uses_disk_storage
              Rails.application.routes.url_helpers.rails_blob_url(attachment, only_path: true)
            else
              attachment.service_url(expires_in: expiry)
            end
          end
          send(:define_method, "#{resource_name}?") do
            (fetch!(resource_name, default_url)&.attached?).present?
          end
          send(:define_method, "generate_#{resource_name}_url!") do |**options|
            force = options[:force] || false
            return nil unless persisted?
            return true if send("#{resource_url}?") && !force

            new_url = send("#{resource_url}!")
            new_url.present? && update(resource_url => new_url)
          end
        end
      end

      private

      def resource_for(resource_name)
        method(resource_name).call
      end
    
      def resource_url_for(resource_name, default_url: '/', expiry: 1.day)
        ensure_attachable_resource!(resource_name)
        resource_url = :"#{resource_name}_url"
        if try(:"db_#{resource_url}?")
          self[resource_url] || default_url
        else
          resource = resource_for(resource_name)
          if resource.attached?
            resource.service_url(expires_in: expiry)
          else
            default_url
          end
        end
      end
    
      def fetch!(resource_name, default_url)
        ensure_attachable_resource!(resource_name)
        resource = resource_for(resource_name)
        #return resource if resource.attached?
    
        #resource.attach(io: File.open("./public/#{default_url}"), filename: "episode-#{id}")
    
      rescue ResourceFetch::ResourceNotAttachable, Errno::ENOENT
        nil
      end
    
      def ensure_fetchable_resource!(resource_name)
        raise NoMethodError, "Don't know how to fetch #{resource_name}" unless respond_to?(resource_name)
      end
    
      def ensure_attachable_resource!(resource_name)
        resource_for(resource_name)
      rescue NameError
        raise ResourceFetch::ResourceNotAttachable.new(resource_name)#, resource unless resource.respond_to?(:attached?)
      end
    end   
  end
end
