defmodule CssColors.RGB do
    defstruct [
      red: 0.0, # 0-255
      green: 0.0, # 0-255
      blue: 0.0, # 0-255
      alpha: 1.0  # 0-1
    ]

    def rgb(red, green, blue, alpha\\1.0)
    def rgb({red, :percent}, {green, :percent}, {blue, :percent}, alpha)  do
      rgb(red * 255, green * 255, blue * 255, alpha)
    end
    def rgb(red, green, blue, alpha)  do
      %__MODULE__{
        red: red/1,
        green: green/1,
        blue: blue/1,
        alpha: alpha/1
      }
    end

    def to_string(struct, type\\nil)

    def to_string(struct, :nil) do
      type = case struct.alpha do
        1.0 -> :hex
        _ -> :rgba
      end
      to_string(struct, type)
    end

    def to_string(%__MODULE__{red: r, green: g, blue: b, alpha: 1.0}, :rgba) do
      "rgba(#{round(r)}, #{round(g)}, #{round(b)})"
    end
    def to_string(%__MODULE__{red: r, green: g, blue: b, alpha: 1.0}, :hex) do
      "#" <> to_hex(r) <> to_hex(g) <> to_hex(b)
    end

    defp to_hex(value) when is_float(value), do:
      to_hex(round(value))
    defp to_hex(value) when value < 10, do:
      "0" <> Integer.to_string(value, 16)
    defp to_hex(value) when is_integer(value), do:
      Integer.to_string(value, 16)
end

defimpl String.Chars, for: CssColors.RGB do
  def to_string(struct) do
    CssColors.RGB.to_string(struct)
  end
end
