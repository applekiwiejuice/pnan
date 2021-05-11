class MakeCombination < ApplicationController

    def make_combo(quantity, combination_of_packs)
        #sort combination_of_packs from max to min
        combination_of_packs.sort! { |a, b| b <=> a }
        
        # memoize solutions
        optimal_combo = Hash.new do |hash, key|
        p hash
        p key
        hash[key] = if key < combination_of_packs.min
            []
        elsif combination_of_packs.include?(key)
            [key]
        else
            combination_of_packs.
            # prune unhelpful coins
            reject { |pack| pack > key }.

            # prune coins that are factors of larger coins
            inject([]) {|mem, var| mem.any? {|c| c%var == 0} ? mem : mem+[var]}.

            # recurse
            map { |pack| [pack] + hash[key - pack] }.

            # prune unhelpful solutions
            reject { |change| change.sum != key }.

            # pick the smallest, empty if none
            min { |a, b| a.size <=> b.size } || []
        end
        end

        optimal_combo[quantity]

    end
end

# Sample Call
# p make_combo(17, array_combination)