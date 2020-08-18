# frozen_string_literal: true

module Primer
  class PopoverComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :message, :heading, :body, :button

    class Message < ViewComponent::Slot
      CARET_DEFAULT = :none
      CARET_MAPPINGS = {
        CARET_DEFAULT => "",
        :bottom => "Popover-message--bottom",
        :bottom_right => "Popover-message--bottom-right",
        :bottom_left => "Popover-message--bottom-left",
        :left => "Popover-message--left",
        :left_bottom => "Popover-message--left-bottom",
        :left_top => "Popover-message--left-top",
        :right => "Popover-message--right",
        :right_bottom => "Popover-message--right-bottom",
        :right_top => "Popover-message--right-top",
        :top_left => "Popover-message--top-left",
        :top_right => "Popover-message--top-right"
      }.freeze

      def initialize(caret: CARET_DEFAULT, large: false, **kwargs)
        @kwargs = kwargs
        @kwargs[:classes] = class_names(
          kwargs[:classes],
          "Popover-message box-shadow-large",
          CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret, CARET_DEFAULT)],
          "Popover-message--large" => large
        )
        @kwargs[:p] = 4 unless kwargs.key?(:p)
        @kwargs[:mt] = 2 unless kwargs.key?(:mt)
        @kwargs[:mx] = :auto unless kwargs.key?(:mx)
        @kwargs[:text_align] = :left unless kwargs.key?(:text_align)
      end

      def component
        Primer::BoxComponent.new(**@kwargs)
      end
    end

    class Heading < ViewComponent::Slot
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:mb] = 2 unless kwargs.key?(:mb)
      end

      def component
        Primer::BaseComponent.new(**@kwargs)
      end
    end

    class Body < ViewComponent::Slot
    end

    class Button < ViewComponent::Slot
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :button
        @kwargs[:mt] = 2 unless kwargs.key?(:mt)
        if @kwargs[:tag] == :button && !@kwargs.key?(:button_type)
          @kwargs[:button_type] = :outline
        end
        @kwargs[:font_weight] = :bold unless @kwargs.key?(:font_weight)
      end

      def component
        if @kwargs[:tag] == :button
          Primer::ButtonComponent.new(**@kwargs)
        else
          Primer::BaseComponent.new(**@kwargs)
        end
      end
    end

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :div
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        "Popover"
      )
      @kwargs[:position] = :relative unless kwargs.key?(:position)
      @kwargs[:right] = false unless kwargs.key?(:right)
      @kwargs[:left] = false unless kwargs.key?(:left)
    end
  end
end
