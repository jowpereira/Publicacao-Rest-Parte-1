//+------------------------------------------------------------------+
//|                                                   example_01.mq5 |
//|                                    Copyright 2023, Lejjo Digital |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Lejjo Digital"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"


#include "libraries/RESTFunctions.mqh"

int OnStart()
  {
//--- CRUD Operations on Posts ---//

// 1. Create a new post
   int userId = 1; // exemplo de userID, você pode ajustar conforme necessário
   string title = "Exemplo de Título";
   string body = "Este é o conteúdo do post para demonstração.";
   int newPostId = CreateNewPost(title, body, userId);
   if(newPostId != -1)
      Print("New Post ID: ", newPostId);

// 2. Update the created post
   string updatedTitle = "Título Atualizado";
   string updatedBody = "Conteúdo do post atualizado.";
   if(UpdatePost(newPostId, updatedTitle, updatedBody))
      Print("Post atualizado com sucesso.");

// 3. Get the updated post
   string fetchedTitle = GetPostById(newPostId);
   if(StringLen(fetchedTitle) > 0)
      Print("Título do Post Obtido: ", fetchedTitle);

// 4. Delete the post
   if(DeletePost(newPostId))
      Print("Post excluído com sucesso.");

//--- Coinbase Operations ---//

   const string buyPrice = GetBitcoinPrice("buy");
   const string sellPrice = GetBitcoinPrice("sell");
   const string spotPrice = GetBitcoinPrice("spot");

   Print("Buy Price: ", buyPrice);
   Print("Sell Price: ", sellPrice);
   Print("Spot Price: ", spotPrice);

   const string currencies = GetAvailableCurrencies();
   Print("Available Currencies: ", currencies);

//---
   return(INIT_SUCCEEDED);
  }
