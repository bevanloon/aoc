class Password
  def call(lower, upper)
    dd = (lower..upper).collect do |number|
      double_digits(number)
    end
    dd.compact
  end

  def double_digits(num)
    dig = num.digits

    # numbers may only ascend.
    return nil unless dig.sort == dig.reverse

    prev = nil
    good_password = false
    three_in_a_row = nil
    dig.each_with_index do |d, i|
      if d == prev && d == dig[i + 1]
        three_in_a_row = d
      end
      if d == prev && d != three_in_a_row
        good_password = true
      end
      prev = d
    end
    return num if good_password
  end
end

RSpec.describe Password do
  it "finds passwords" do
    x = Password.new
    res = x.call(138241, 674034)
    p res.count
  end
end
