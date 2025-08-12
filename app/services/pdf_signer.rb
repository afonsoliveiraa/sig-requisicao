class PdfSigner
  require "prawn"
  require "prawn/templates"
  require "base64"
  require "tempfile"

  def self.assinar(pdf_base64)
    Tempfile.create(["original", ".pdf"]) do |file|
      file.binmode
      file.write(Base64.decode64(pdf_base64))
      file.flush

      pdf = Prawn::Document.new(skip_page_creation: true)
      pdf.start_new_page(template: file.path)

      texto = "ASSINADO DIGITALMENTE"
      font_size = 6   # texto menor para caber melhor
      margin_right = 1
      margin_top = 500  # ajuste vertical que desejar

      # Posição na borda direita: x perto da largura total - margem,
      # y o topo menos margem, pois a coordenada y é do topo para baixo
      x = pdf.bounds.right - margin_right
      y = pdf.bounds.top - margin_top

      pdf.text_box texto,
        at: [x, y],
        width: 100,          # largura do box (ajuste para o texto caber)
        height: font_size * 3,
        size: font_size,
        style: :bold,
        align: :center,
        rotate: 90,          # rotaciona 90 graus (texto vertical)
        rotate_around: :bottom_left # gira em torno do canto para posicionar melhor

      pdf_data = pdf.render
      Base64.strict_encode64(pdf_data)
    end
  end
end
