# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class PandocCrossref < Formula
  include Language::Haskell::Cabal

  desc "A pandoc filter for numbering figures, equations, tables and cross-references to them."
  homepage "https://github.com/lierdakil/pandoc-crossref"
  url "https://hackage.haskell.org/package/pandoc-crossref-0.2.0.1/pandoc-crossref-0.2.0.1.tar.gz"
  version "0.2.0.1"
  sha256 "44bdbc38d8d7a743951a2333fb70b33a6497b2d50ccdb5696736fdc5133aef21"

depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "pandoc"

  def install
    args = []
    args << "--constraint=cryptonite -support_aesni" if MacOS.version <= :lion
    install_cabal_package *args
  end

  test do
    md = testpath/"test.md"
    md.write <<-EOS.undent
      Demo for pandoc-crossref.  
      See equation @eq:eqn1 for cross-referencing.  
      Display equations are labelled and numbered  

      $$ P_i(x) = \sum_i a_i x^i $$ {#eq:eqn1}


    EOS
    system "pandoc", "-F", "pandoc-crossref", md
  end

end
