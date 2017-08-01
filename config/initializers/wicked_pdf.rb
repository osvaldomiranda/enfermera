WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  :exe_path => Rails.env.production? ? '/usr/local/bin/wkhtmltopdf.sh' : '/Users/osvaldo/.rbenv/shims/wkhtmltopdf' ,
  #:exe_path => '/Users/Osvaldo/.rbenv/shims/wkhtmltopdf',
  :page_size=>"Letter",
  # :exe_path => '/usr/local/bin/wkhtmltopdf',
  :encoding => "UTF-8"
}
