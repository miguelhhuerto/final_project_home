class InviteController < ApplicationController
before_action :set_user
before_action :generate_qrcode

  
  def index
    @user=current_user
  end

  private

  def set_user
    @user=current_user
  end

  def generate_qrcode
    qrcode = RQRCode::QRCode.new("client.com:3000"+new_user_registration_path(promoter: @user.email).to_s)

    # NOTE: showing with default options specified explicitly
    @png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    # @svg = qrcode.as_ansi(
    #   light: "\033[47m", dark: "\033[40m",
    #   fill_character: "  ",
    #   quiet_zone_size: 4
    # )
  end

end
