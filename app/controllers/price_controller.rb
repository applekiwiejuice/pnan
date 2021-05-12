class PriceController < ApplicationController

  #STEP 1 GET AND RETURN DATA TO VIEW
  def accept_and_return_combo
    @item_id = params[:item_id]
    @item_code = params[:item_code]
    @quantity = params[:quantity]
    quantity = params[:quantity]
    @details = Item.find(params[:item_id])
    details = @details
    quantity_array = []

    details.packs.each do |list|
      quantity_array.push(list.quantity)
    end

    @array = quantity_array
    @best_combo = make_combo(quantity.to_i, quantity_array)
    best_combo = @best_combo

    @total_breakdown = total_breakdown(details, best_combo)
    @calculation = calculate_price(details, best_combo)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render partial: 'home/price_result' }
    end
  end

  #STEP 2 GENERATE THE BEST COMBINATION
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
          reject { |pack| pack > key }.
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

  #STEP 3 GET THE TOTAL BREAKDOWN
  def total_breakdown(details, best_combo)
    packs_hash = {}
    combo_tally = best_combo.tally
    calculation_breakdown_array = []

    details.packs.map do |value|
      packs_hash[value.quantity] = value.price.to_f
    end

    total = 0
    combo_tally.each do |pack, tally|
      tally_singular_or_plural = tally == 1 ? " pack of " : " packs of "
      breakdown_string = tally.to_s + tally_singular_or_plural + pack.to_s + " = " + (packs_hash[pack] * tally).to_s
      calculation_breakdown_array.push(breakdown_string)
    end
    calculation_breakdown_array
  end

  def calculate_price(details, best_combo)
    packs_hash = {}
    combo_tally = best_combo.tally

    details.packs.map do |value|
      packs_hash[value.quantity] = value.price.to_f
    end

    total = 0
    combo_tally.each do |pack, tally|
      total += packs_hash[pack] * tally
    end
    total
  end

end