module ValidSudoku
  module Collection

    NULL_VALUE = 0.freeze
    ALLOWED_VALUES = (0..9).to_a.freeze
    VALID_SIZE = 9.freeze

    def valid_collection?(collection)
      valid_size?(collection) &&
      allowed_values?(collection) &&
      no_duplicate_values?(collection)
    end

    def valid_size?(collection)
      collection.size == VALID_SIZE
    end

    def allowed_values?(collection)
      collection.all? { |value| ALLOWED_VALUES.member?(value) }
    end

    def no_duplicate_values?(collection)
      removed_nils = collection.reject { |value| value == NULL_VALUE }
      removed_nils.size == removed_nils.uniq.size
    end

    def complete?(collection)
      collection.select { |value| value == NULL_VALUE }.empty?
    end
  end
end
