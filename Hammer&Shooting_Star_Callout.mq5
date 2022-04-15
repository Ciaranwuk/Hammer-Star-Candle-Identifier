int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
   
  }

void OnTick(){
   
   //Determine Candle High
   double candleHigh = iHigh(_Symbol, PERIOD_CURRENT, 0);
   candleHigh = NormalizeDouble(candleHigh, _Digits);
   
   //Determine Candle Low
   double candleLow = iLow(_Symbol, PERIOD_CURRENT, 0);
   candleLow = NormalizeDouble(candleLow, _Digits);
   
   //Candle Open
   double candleOpen = iOpen(_Symbol, PERIOD_CURRENT, 0);
   candleOpen = NormalizeDouble(candleOpen, _Digits);
   
   //Current Bid
   double cBid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   cBid = NormalizeDouble(cBid, _Digits);
   
   //Determine which half of the range price is in
   double cRange = candleHigh - candleLow;
   cRange = NormalizeDouble(cRange, _Digits);
   double priceInRange = cBid - candleLow;
   priceInRange = NormalizeDouble(priceInRange, _Digits);
   
   //is it a hammer?
   bool hammer = false;
   
   //is it a shooting star?
   bool shootingStar = false;
   
   //Determine Bull or Bear candle
   if(cBid > candleOpen){
   
      //Wick to Body size
      double candleBody = cBid - candleOpen;
      candleBody = NormalizeDouble(candleBody, _Digits);
      
      double lWick = candleOpen - candleLow;
      lWick = NormalizeDouble(lWick, _Digits);
      
      double hWick = candleHigh - cBid;
         hWick = NormalizeDouble(hWick, _Digits);

      //price in top or bottom half of range?      
      if(priceInRange > (cRange/2)){                 
         //large low wick, small top wick
         if(lWick >= 2*candleBody && hWick < (lWick/2)){
            Comment("Hammer");
            hammer = true;
            Print(hammer, shootingStar);
         }else{
            Comment("-");
            hammer = false;
            Print(hammer, shootingStar);
         }
         
      }if(priceInRange < (cRange/2)){
         //large high wick, small low wick
         if(hWick >= 2*candleBody && lWick < (hWick/2)){
            Comment("Shooting Star");
            shootingStar = true;
            Print(hammer, shootingStar);
         }else{
            Comment("-");
            shootingStar = false;
            Print(hammer, shootingStar);
         }
      }
      
    }
      
    if(cBid < candleOpen){
       //Wick to Body size
       double candleBody = candleOpen - cBid;
       candleBody = NormalizeDouble(candleBody, _Digits);
         
       double hWick = candleHigh - candleOpen;
       hWick = NormalizeDouble(hWick, _Digits);
         
       double lWick = cBid - candleLow;
       lWick = NormalizeDouble(lWick, _Digits);
         
       if(priceInRange < (cRange/2)){
          if(hWick >= 2*candleBody && lWick < (hWick/2)){
            Comment("Shooting Star");
            shootingStar = true;
            Print(hammer, shootingStar);
          }else{
            Comment("-");
            shootingStar = false;
            Print(hammer, shootingStar);
          }
       } 
         
       if(priceInRange > (cRange/2)){
          if(lWick >= 2*candleBody && hWick < (lWick/2)){
            Comment("Hammer");
            hammer = true;
            Print(hammer, shootingStar);
          }else{
            Comment("-");
            hammer = false;
            Print(hammer, shootingStar);
          }           
       }
              
    }      
           
 }


