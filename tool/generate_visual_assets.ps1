Add-Type -AssemblyName System.Drawing

function New-RoundedPath {
  param(
    [System.Drawing.Rectangle]$Rect,
    [int]$Radius
  )

  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $diameter = $Radius * 2
  $path.AddArc($Rect.X, $Rect.Y, $diameter, $diameter, 180, 90)
  $path.AddArc($Rect.Right - $diameter, $Rect.Y, $diameter, $diameter, 270, 90)
  $path.AddArc($Rect.Right - $diameter, $Rect.Bottom - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($Rect.X, $Rect.Bottom - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()
  return $path
}

function New-Logo {
  $w = 900
  $h = 900
  $bmp = New-Object System.Drawing.Bitmap $w, $h
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear([System.Drawing.Color]::Transparent)

  $teal = [System.Drawing.Color]::FromArgb(255, 0, 88, 108)
  $green = [System.Drawing.Color]::FromArgb(255, 92, 126, 102)
  $orange = [System.Drawing.Color]::FromArgb(255, 255, 170, 118)
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush ([System.Drawing.Rectangle]::new(140, 110, 600, 540)), $teal, $orange, 0
  $pen = New-Object System.Drawing.Pen $brush, 34
  $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
  $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
  $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round

  $bagPen = New-Object System.Drawing.Pen $orange, 24
  $bagPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
  $bagPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
  $bagPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
  $g.DrawArc($bagPen, 385, 170, 230, 210, 190, 210)
  $g.DrawLine($bagPen, 610, 310, 710, 310)
  $g.DrawLine($bagPen, 710, 310, 710, 610)
  $g.DrawLine($bagPen, 710, 610, 540, 610)

  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $path.AddBezier(390, 150, 245, 130, 235, 290, 350, 305)
  $path.AddBezier(350, 305, 520, 330, 520, 455, 325, 500)
  $path.AddBezier(325, 500, 190, 530, 205, 675, 370, 675)
  $path.AddBezier(370, 675, 540, 675, 560, 520, 410, 465)
  $path.AddBezier(410, 465, 315, 430, 318, 360, 430, 365)
  $path.AddBezier(430, 365, 515, 370, 555, 450, 520, 525)
  $g.DrawPath($pen, $path)

  $leafBrush = New-Object System.Drawing.SolidBrush $green
  $leaf = New-Object System.Drawing.Drawing2D.GraphicsPath
  $leaf.AddBezier(410, 342, 462, 350, 488, 392, 484, 438)
  $leaf.AddBezier(484, 438, 438, 427, 412, 392, 410, 342)
  $g.FillPath($leafBrush, $leaf)

  $sparkBrush = New-Object System.Drawing.SolidBrush $orange
  $spark = New-Object System.Drawing.Drawing2D.GraphicsPath
  $spark.AddPolygon(@(
      [System.Drawing.Point]::new(555, 325),
      [System.Drawing.Point]::new(574, 360),
      [System.Drawing.Point]::new(610, 378),
      [System.Drawing.Point]::new(574, 397),
      [System.Drawing.Point]::new(555, 432),
      [System.Drawing.Point]::new(536, 397),
      [System.Drawing.Point]::new(500, 378),
      [System.Drawing.Point]::new(536, 360)
    ))
  $g.FillPath($sparkBrush, $spark)

  $font = New-Object System.Drawing.Font 'Segoe UI', 96, ([System.Drawing.FontStyle]::Bold)
  $textBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush ([System.Drawing.Rectangle]::new(90, 705, 720, 130)), $teal, $orange, 0
  $fmt = New-Object System.Drawing.StringFormat
  $fmt.Alignment = [System.Drawing.StringAlignment]::Center
  $g.DrawString('ShopEase', $font, $textBrush, [System.Drawing.RectangleF]::new(0, 705, $w, 145), $fmt)

  $bmp.Save('assets/images/shopease_logo.png', [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose()
  $bmp.Dispose()
}

function New-Header {
  $w = 1400
  $h = 620
  $bmp = New-Object System.Drawing.Bitmap $w, $h
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush ([System.Drawing.Rectangle]::new(0, 0, $w, $h)), ([System.Drawing.Color]::FromArgb(255, 117, 78, 46)), ([System.Drawing.Color]::FromArgb(255, 240, 213, 192)), 0
  $g.FillRectangle($bg, 0, 0, $w, $h)

  $veil = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(95, 80, 48, 28))
  $g.FillRectangle($veil, 0, 0, $w, $h)

  $skin = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(210, 215, 156, 118))
  $hair = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(160, 58, 35, 25))
  $gold = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(245, 244, 205, 124))
  $cream = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(210, 255, 244, 230))

  $g.FillEllipse($hair, 840, -80, 420, 460)
  $g.FillEllipse($skin, 870, 45, 290, 350)
  $g.FillEllipse($cream, 1030, 220, 34, 34)
  $g.FillRectangle($cream, 1044, 248, 6, 85)
  for ($i = 0; $i -lt 4; $i++) {
    $g.FillRectangle($gold, 1016 + $i * 21, 320, 9, 70)
  }
  $g.FillEllipse($gold, 1005, 300, 115, 28)

  $handPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(180, 220, 165, 132)), 42
  $handPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
  $handPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
  $g.DrawBezier($handPen, 720, 455, 820, 360, 900, 300, 985, 250)
  $g.DrawBezier($handPen, 755, 485, 850, 455, 910, 390, 1010, 325)

  $ringPen = New-Object System.Drawing.Pen $gold, 8
  $g.DrawEllipse($ringPen, 890, 365, 42, 24)

  $cardBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(175, 255, 255, 255))
  $cardPath = New-RoundedPath -Rect ([System.Drawing.Rectangle]::new(680, 405, 360, 112)) -Radius 24
  $g.FillPath($cardBrush, $cardPath)
  $g.FillEllipse($gold, 710, 435, 80, 36)

  $fontSmall = New-Object System.Drawing.Font 'Segoe UI', 24, ([System.Drawing.FontStyle]::Bold)
  $fontTiny = New-Object System.Drawing.Font 'Segoe UI', 16
  $text = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 70, 47, 34))
  $g.DrawString('Beautiful In Every Detail', $fontSmall, $text, 815, 426)
  $g.DrawString('Curated style for everyday shopping', $fontTiny, $text, 818, 465)

  $bmp.Save('assets/images/header_lifestyle.png', [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose()
  $bmp.Dispose()
}

New-Logo
New-Header
