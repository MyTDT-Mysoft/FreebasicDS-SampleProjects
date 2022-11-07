enum PlayerKind
  pkGoalKeeper = 0
  pkDefender
  pkSide
  pkMiddle
  pkAttacker
end enum

scope ' **** Team Data ****                                                            
  '_TeamData_:  ' Shotting Running Passing Defense Tackling Goalies                     
  '                 Team Name       Score  T-Shirt  Shorts  Flag    S R P D T G          
  Teams( 0) = type(@"Argentina",     76,     11,      8,     1  ) ' 8 6 9 8 7 8 - 3/15/3  
  Teams( 1) = type(@"Australia",     55,     14,      3,     20 ) ' 4 7 5 7 5 5 - 4/15/1 
  Teams( 2) = type(@"Belgium",       68,      4,      5,     12 ) ' 6 7 8 7 6 7 - 13/14/4 
  Teams( 3) = type(@"Brazil",        80,     14,      1,     11 ) ' 8 8 9 7 8 8 - 2/14/1 
  Teams( 4) = type(@"Canada",        50,      4,      5,     23 ) ' 4 6 4 5 5 6 - 4/15/4  
  Teams( 5) = type(@"Chile",         57,      4,      1,     16 ) ' 7 6 6 4 5 6 - 1/15/4 
  Teams( 6) = type(@"Czech Republic",60,      4,      7,     21 ) ' 6 5 6 7 6 6 - 15/4    
  Teams( 7) = type(@"England",       68,      7,      1,     13 ) ' 6 8 6 7 7 7 - 4/15   
  Teams( 8) = type(@"France",        68,      1,      7,     6  ) ' 7 6 8 6 6 8 - 1/15/4  
  Teams( 9) = type(@"Germany",       82,      7,      8,     2  ) ' 9 8 8 8 8 8 - 13/4/6 
  Teams(10) = type(@"Greece",        52,      7,      1,     9  ) ' 6 6 6 4 6 3 - 15/1    
  Teams(11) = type(@"Holland",       78,     12,      7,     3  ) ' 8 9 9 6 6 9 - 4/15/1 
  Teams(12) = type(@"Italy",         87,      1,      7,     4  ) ' 8 9 9 9 8 9 - 2/15/4  
  Teams(13) = type(@"Japan",         53,      1,      7,     19 ) ' 4 6 5 6 5 6 - 4/15   
  Teams(14) = type(@"Norway",        67,      4,      7,     15 ) ' 6 6 8 6 7 7 - 1/15/4  
  Teams(15) = type(@"Portugal",      58,      4,      3,     22 ) ' 7 6 7 4 5 6 - 2/4    
  Teams(16) = type(@"Russia",        62,      7,      8,     0  ) ' 7 9 7 3 5 6 - 4/15/1  
  Teams(17) = type(@"South Korea",   40,      4,      1,     17 ) ' 2 6 6 4 2 4 - 4/1/15 
  Teams(18) = type(@"Spain",         73,      4,      1,     8  ) ' 8 7 7 7 7 8 - 4/14/4  
  Teams(19) = type(@"Sweden",        58,      4,      9,     5  ) ' 6 7 5 6 5 6 - 14/1   
  Teams(20) = type(@"Switzerland",   58,      4,      7,     10 ) ' 7 6 6 7 4 5 - 15/4    
  Teams(21) = type(@"Tunisia",       57,     12,      7,     18 ) ' 4 6 5 6 6 7 - 4/15   
  Teams(22) = type(@"Uruguay",       62,      7,      1,     14 ) ' 7 6 7 6 5 6 - 1/15/14 
  Teams(23) = type(@"Usa",           47,     14,      1,     7  ) ' 4 6 4 5 4 5 - 4/15/1 
  ' **** Formation Data ****                                                            
  FORM(0) = type( @"3-5-2" , { (40,120,pkGoalKeeper) , _ 'Formation Name / Goal Keeper 
  (120, 60,pkDefender), (110,120,pkDefender), (120,180,pkDefender), _ 'Defense        
  (200, 50,pkSide    ), (200,190,pkSide    ), _                       'Sides         
  (180, 90,pkMiddle  ), (220,130,pkMiddle  ), (180,160,pkMiddle  ), _ 'Middle        
  (275,100,PkAttacker), (285,160,pkAttacker) } )                      'Attack         
  FORM(1) = type( @"4-4-2" , { (40,120,pkGoalKeeper) , _ 'Formation Name / Goal Keeper 
  (130, 80,pkDefender), (135,180,pkDefender), _                       'Defense A       
  (105,110,PkDefender), (110,150,pkDefender), _                       'Defense B      
  (190, 80,pkSide    ), (185,180,pkSide    ), _                       'Sides         
  (210,110,pkMiddle  ), (205,150,pkMiddle  ), _                       'Middle         
  (275,100,PkAttacker), (285,160,pkAttacker) } )                      'Attack          
  FORM(2) = type( @"1-3-4-2",{ (40,120,pkGoalKeeper) , _ 'Formation Name / Goal Keeper 
  ( 95,100,pkDefender), _                                             'Shark          
  (125, 60,pkDefender), (115,120,pkDefender), (120,180,pkDefender), _ 'Defense       
  (185,180,pkSide    ), (190,180,pkSide    ), _                       'Sides        
  (205,110,pkMiddle  ), (210,150,pkMiddle  ), _                       'Middle        
  (285,100,PkAttacker), (275,160,pkAttacker) } )                      'Attack         
  FORM(3) = type( @"4-2-4" , { (40,120,pkGoalKeeper) , _ 'Formation Name / Goal Keeper 
  (130, 80,pkDefender), (130,180,pkDefender), _                       'Defense A      
  (105,110,PkDefender), (105,150,pkDefender), _                       'Defense B     
  (190,110,pkSide    ), (190,150,pkSide    ), _                       'Sides        
  (270, 80,pkAttacker), (270,180,pkAttacker), _                       'Attack        
  (290,110,PkAttacker), (290,150,pkAttacker) } )                      'Attack         
  FORM(4) = type( @"4-3-3" , { (40,120,pkGoalKeeper) , _ 'Formation Name / Goal Keeper 
  (130, 80,pkDefender), (135,180,pkDefender), _                       'Defense A      
  (105,110,PkDefender), (110,150,pkDefender), _                       'Defense B     
  (200, 60,pkSide    ), (210,120,pkMiddle  ), (195,180,pkSide    ), _ 'Side/Middle  
  (275, 60,pkAttacker), (295,120,pkAttacker), (275,180,pkAttacker) }) 'Attack      
end scope '                                                                       

_FormationData_:



















































































