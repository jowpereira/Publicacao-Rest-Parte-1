//+------------------------------------------------------------------+
//|                                            RESTFunctions.mqh.mq5 |
//|                                    Copyright 2023, Lejjo Digital |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright 2023, Lejjo Digital"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"

#include <JAson.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetPostById(int postId)
  {
   char data[];
   uchar result[];
   string result_headers;
   string url = StringFormat("https://jsonplaceholder.typicode.com/posts/%d", postId);
   int timeout = 5000;

   int res = WebRequest("GET", url, NULL, timeout, data, result, result_headers);

   if(res > 0)
     {
      CJAVal jv;
      if(jv.Deserialize(result))
        {
         string postTitle = jv["title"].ToStr();
         Print("Post title: ", postTitle);
         return postTitle;
        }
      else
        {
         Print("Error: Unable to parse the response.");
        }
     }
   else
     {
      Print("Error: Failed to fetch post.");
     }

   return "";
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool UpdatePost(int postId, string newTitle, string newBody)
  {
   uchar result[];
   string result_headers;
   string url = StringFormat("https://jsonplaceholder.typicode.com/posts/%d", postId);

   char put_data[]; // Declare post_data as char[]
   StringToCharArray(StringFormat("{\"title\": \"%s\", \"body\": \"%s\"}", newTitle, newBody), put_data);

   string headers = "Content-Type: application/json\r\n"; // Declare headers as char[]
   int timeout = 5000;

   int res = WebRequest("PUT", url, headers, timeout, put_data, result, result_headers);

   if(res > 0)
     {
      Print("Post updated successfully.");
      return true;
     }
   else
     {
      Print("Error: Failed to update post.");
      return false;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool DeletePost(int postId)
  {
   char data[];
   uchar result[];
   string result_headers;
   string url = StringFormat("https://jsonplaceholder.typicode.com/posts/%d", postId);
   int timeout = 5000;

   int res = WebRequest("DELETE", url, NULL, timeout, data, result, result_headers);

   if(res > 0)
     {
      Print("Post deleted successfully.");
      return true;
     }
   else
     {
      Print("Error: Failed to delete post.");
      return false;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CreateNewPost(string title, string body, int userId)
  {
   uchar result[];
   string result_headers;
   string url = "https://jsonplaceholder.typicode.com/posts";

   char post_data[];
   StringToCharArray(StringFormat("{\"title\": \"%s\", \"body\": \"%s\", \"userId\": %d}", title, body, userId), post_data);

   string headers = "Content-Type: application/json\r\n";
   int timeout = 5000;

   int res = WebRequest("POST", url, headers, timeout, post_data, result, result_headers);

   if(res > 0)
     {
      Print("Post created successfully.");
     }
   else
     {
      Print("Error: Failed to create post.");
     }

   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetBitcoinPrice(string priceType)
  {
   char data[];
   uchar result[];
   string result_headers;

   string baseURL = "https://api.coinbase.com/v2/prices/";
   if(priceType == "buy")
      baseURL += "buy";
   else
      if(priceType == "sell")
         baseURL += "sell";
      else
         baseURL += "spot";

   string url = baseURL + "?currency=USD";
   char headers[];
   int timeout = 5000;
   int res;

   Print("Fetching Bitcoin price for type: ", priceType);
   res = WebRequest("GET", url, NULL, NULL, timeout, data, 0, result, result_headers);

   string price = "";
   if(res > 0)
     {
      Print("Response received from Coinbase API");

      CJAVal jv;
      if(jv.Deserialize(result))
        {
         price = jv["data"]["amount"].ToStr();
         Print("Price fetched: ", price, "\n");
        }
      else
        {
         Print("Error: Unable to parse the response.\n");
        }
     }
   else
     {
      Print("Error: No response from Coinbase API or an error occurred.\n");
     }

   return price;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetAvailableCurrencies()
  {
   char data[];
   uchar result[];
   string result_headers;
   string url = "https://api.coinbase.com/v2/currencies";
   char headers[];
   int timeout = 5000;
   int res;

   Print("Fetching list of available currencies from Coinbase API");
   res = WebRequest("GET", url, NULL, NULL, timeout, data, 0, result, result_headers);

   string currencies = "";
   if(res > 0)
     {
      Print("Response received from Coinbase API");

      CJAVal jv;
      if(jv.Deserialize(result))
        {
         // Considerando que a resposta é uma lista de moedas
         for(int i = 0; i < jv["data"].Size(); i++)
           {
            currencies += "Currency: " + jv["data"][i]["id"].ToStr();
            currencies += ", Name: " + jv["data"][i]["name"].ToStr();
            currencies += ", Min Size: " + jv["data"][i]["min_size"].ToStr();
            currencies += "\n";
           }
         Print(currencies);
        }
      else
        {
         Print("Error: Unable to parse the response.");
        }
     }
   else
     {
      Print("Error: No response from Coinbase API or an error occurred.");
     }

   return currencies;
  }
//+------------------------------------------------------------------+
