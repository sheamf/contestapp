class ContestResults

  def initialize(arr)
    raise ArgumentError.new("an array is required.") if arr.blank?
    @arr = arr
  end

  # picks <count> winners
  def results(count=1)
    if count.to_i < 2
      arr.sample
    else
      arr.sample(count)
    end

  end

  private

  attr_reader :arr

end