class Validator
  VALID_RESULT ='123456789'
  MAX_NUMBER = 9
  SUCCESS = 'Sudoku is valid.'
  INCOMPLETE = 'Sudoku is valid but incomplete.'
  INVALID = 'Sudoku is invalid.'

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    input = @puzzle_string.gsub(/[-+]/,'-'=>'', '+'=>'').split("\n").reject{|i| i.empty?}
    input_array = Array.new(Array.new(input.length))

    for i in (0..input.length-1)
      input_array[i] = input[i].split('|').join('')
    end
    validate_row(input_array)
  end

  def validate_row(input_array)
    for row in (0..input_array.length-1)
      int_map = input_array[row].split(' ').map{|x| x.to_i}

      if int_map.sort[-1] > MAX_NUMBER
          return INVALID
      end
      if int_map.sort[0] < 1
        return INCOMPLETE
      end
      if int_map.sort.join != VALID_RESULT
        return INVALID
      end
    end
    validate_columns(input_array)
  end

  def validate_columns(input_array)
    input_array = input_array.map{|value| value.delete(' ')}

    for i in (0..input_array.length-1)
      result = ''
      for j in (0..input_array.length-1)
        result.concat(input_array[j][i])
      end
      if result.chars.sort.join != VALID_RESULT
        return INVALID
      end
    end
    return SUCCESS
  end
end
