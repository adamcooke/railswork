module ActsAsProtected
  def self.included(base)
    base.extend ClassMethods
  end
  
    module ClassMethods
      def acts_as_protected(options = {})
        return if self.included_modules.include?(ActsAsProtected::ActMethods)
        send :include, ActsAsProtected::ActMethods
      end
    end 
    
    module ActMethods
        
      def self.included(base)
        base.extend ClassMethods
      end
      
      def update_permissions(dataset, options = {})
        field_name = options[:field].to_s ||= "access_level"
        total = 0
        unless dataset.blank?
          dataset.each do |value|
            total = total + value.to_i
          end
         end
        update_attribute field_name, total
      end
  
    end
end