module Ruckus
    module StructureDetectFactory
        def factory?
            # self.respond_to? :factory
            # self.structure_field_names.try(:has_key?, :decides)
            @factory ||=false
        end

        def structure_field_def_hook(*a)
            args = a[0]
            opts = args[0].respond_to?(:has_key?) ? args[0] : args[1]
            if opts.try(:has_key?, :decides)
              include StructureFactory
              self.instance_eval{@factory = true}
            end
            super
        end
    end

    module StructureFactory
        def self.included(klass)
            klass.extend(ClassMethods)
        end

        module ClassMethods
            def factory(str)
                orig = str.clone
                (tmp = self.new).capture(str)
                tmp.each_field do |n, f|
                    if (m = f.try(:decides))
                        klass = m[f.value]
                        if klass
                            o = derive_search_module.const_get(klass.to_s.class_name).new
                            if o.class.factory?
                                o, orig = o.class.factory(orig)
                            else
                                orig = o.capture(orig)
                            end
                            return o, orig
                        end
                    end
                end
                return false
            end
        end
    end
end
