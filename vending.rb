class VendingMachine
  attr_reader :sales_money, :drink_stock

  def initialize()
    @drink_stock = DrinkStock.new
    # @items = items
    @slot_money = 0
    @sales_money = 0
  end

  def items
    @drink_stock.items
  end

  MONEY = [10, 50, 100, 500, 1000].freeze

  def slot_money(money)
    unless MONEY.include?(money)
      puts "お取り扱いできません"
      return display_return_money(money)
    end
    @slot_money += money
    puts "投入金額:#{@slot_money}円"
  end

  def current_slot_money
    @slot_money
  end

  def add_drink
    @drink_stock.add_item(xxx)
  end

  # def return_money
  #   if @reject_money != 0
  #     puts "お釣りは #{@reject_money}円です"
  #     @reject_money = 0
  #   else
  #     puts "お釣りは #{@slot_money}円です"
  #     @slot_money = 0
  #   end
  # end

  def display_return_money(money)
    puts "お釣りは #{money}円です"
  end

  def sales
    puts "売り上げ: #{@sales_money}円"
  end

  # 動作を表現したい時は動詞+名詞のほうがわかりやすいかも
  def display_menu
    puts "メニューはこちらです"
    puts "*" * 50
    @drink_stock.item.each_with_index do |item, i|
      puts "#{i}: #{item[:name]} (#{item[:price]}円)" if buyable?(i)
    end
    puts "*" * 50
  end

  def purchase(drink_number)
    if buyable?(drink_number)
      puts "#{items[drink_number][:name]} を購入しました!"
      items[drink_number][:stock] -= 1
      @sales_money += items[drink_number][:price]
      # @slot_money = current_slot_money - items[drink_number][:price]
      @slot_money -= items[drink_number][:price]
      display_return_money(@slot_money)
      @slot_money = 0
    end
  end

  private

  # true falseを返すメソッドには?をつけるのがrubyだとよくやる
  def buyable?(drink_number)
    items[drink_number][:price] <= @slot_money && items[drink_number][:stock] > 0
  end

  def item_info
    items.each do |item|
      puts "名前: #{item[:name]}  値段: #{item[:price]}  在庫: #{item[:stock]}個"
    end
  end
end

class DrinkStock
  attr_reader :items

  def initialize
    # 変数に型がないので、単数複数形をちゃんと表現したほうが、中身がわかりやすい
    @items = [{name: "コーラ", price: 120, stock: 5}]
  end

  def add_item(name, price)
    @items.push({name: name, price: price, stock: 5})
  end

  def item_reset
    @items = []
  end

  def current_item
    @items
  end

  def item_info
    @items.each do |item|
      puts "名前: #{item[:name]}  値段: #{item[:price]}  在庫: #{item[:stock]}個"
    end
  end
end

class Drink
  attr_reader :name, :price
end

# require "./vending"
# drink = DrinkStock.new
# drink.add_item("水", 100)
# drink.add_item("レッドブル", 200)
# items = drink.current_item
# vm = VendingMachine.new(items)
# vm.slot_money (1000)
# vm.slot_money (777)
# vm.menu
# vm.purchase(0)

# drink.item_info
# drink.item_reset
# vm.judge(0)
# vm.return_money
# vm.sales
# vm.item_info
# vm.drink_stock.add_item(xxx)
