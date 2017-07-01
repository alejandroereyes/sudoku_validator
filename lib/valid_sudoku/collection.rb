module ValidSudoku
  class Collection
    attr_reader :collection

    NULL_VALUE = 0.freeze
    ALLOWED_VALUES = (0..9).to_a.freeze
    VALID_SIZE = 9.freeze

    def initialize(collection)
      @collection = collection
    end

    def valid?
      valid_size?(collection) &&
      allowed_values?(collection) &&
      no_duplicate_values?
    end

    def valid_size?
      collection.size == VALID_SIZE
    end

    def allowed_values?
      collection.all? { |value| ALLOWED_VALUES.member?(value) }
    end

    def no_duplicate_values?
      collection.size == collection.uniq.size
    end

    def complete?
      collection.select { |value| value == NULL_VALUE }.empty?
    end
  end
end
