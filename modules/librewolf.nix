{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    policies = {
      SearchEngines = {
        Name = "Jisho.org";
        URLTemplate = "https://jisho.org/search/{searchTerms}";
        Method = "GET | POST";
        IconURL = "https://assets.jisho.org/assets/favicon-062c4a0240e1e6d72c38aa524742c2d558ee6234497d91dd6b75a182ea823d65.ico";
        Alias = "j";
        Description = "Powerful and easy-to-use online Japanese dictionary with words, kanji and example sentences.";
      };
    };
  };
} 
