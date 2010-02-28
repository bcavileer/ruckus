class Module
    module ModuleExtensions
        def to_name_hash
            # XXX not used
            @name_hash ||= constants.map {|k| [k.intern, const_get(k.intern)]}.to_hash
        end

        def to_key_hash
            # XXX not used
            @key_hash ||= constants.map {|k| [const_get(k.intern), k.intern]}.to_hash
        end

        def flag_dump(i)
            # XXX not used
            @bit_map ||= constants.map do |k|
                [k, const_get(k.intern).ffs]
            end.sort {|x, y| x[1] <=> y[1]}

            last = 0
            r = ""
            @bit_map.each do |tup|
                if((v = (tup[1] - last)) > 1)
                    r << ("." * (v-1))
                end

                if((i & (1 << tup[1])) != 0)
                    r << tup[0][0].chr
                else
                    r << tup[0][0].chr.downcase
                end
                last = tup[1]
            end
            return r.reverse
        end
    end
    include ModuleExtensions
end
