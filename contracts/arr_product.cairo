%builtins output
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc

# Computes the sum of the memory elements at addresses:
#   arr + 0, arr + 1, ..., arr + (size - 1).
func arr_prod(arr : felt*, size) -> (sum : felt):
    if size == 0:
        return (sum=1)
    end

    # size is not zero.
    let (sum_of_rest) = arr_prod(arr=arr + 1, size=size - 1)
    return (sum=[arr] * sum_of_rest)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 3

    # Allocate an array.
    # let (num_array) = alloc()

    # Populate some values in the array.
    # assert [num_array] = 2
    # assert [num_array + 1] = 2
    # assert [num_array + 2] = 2
    # let (sum) = arr_prod(num_array, ARRAY_SIZE)
    # serialize_word(sum)
    serialize_word(6 / 3)
    serialize_word(7 / 3)

    return ()
end
