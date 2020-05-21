//import java.util.*;

Board game;
boolean turn = true;
boolean first = true;
boolean adopt = false;
String details = "";
int r = -1, f = -1, r1 = -1, f1 = -1;
boolean doPr = false;  // will be promoting a piece or not
boolean doDr = false;  // will be dropping a piece or not.
int timeS = -1, timeP = -1, timeI = -1;
Double cycleTime = new Double(0);
//for selecting pieces

void setup()
{
  size(358, 479);
  background(200);
  game = new Board();
}

void draw()
{
  background(200);
  details = "";
  game.show(turn);
  cycleTime = new Double(millis() % 4000);  
  
  if ( cycleTime.doubleValue() > -1.0 && cycleTime.doubleValue() < 1000.0 )
  {
      
    timeS--;
    timeP--;
    timeI--;
  }  
  
  if ( timeS == 3 )
  {
    image(loadImage("selector3.png"), f * 34 + 1, r * 34 + 87 );
  }
  else if ( timeS == 2 )
  {
    image(loadImage("selector2.png"), f * 34 + 1, r * 34 + 87 );
  }
  else if ( timeS == 1 )
  {
    image(loadImage("selector1.png"), f * 34 + 1, r * 34 + 87 );
  }
  else if ( timeS == 0 )
  {
    image(loadImage("selector0.png"), f * 34 + 1, r * 34 + 87 );
  }
  
  if ( timeP == 3 )
  {
    image(loadImage("placer3.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  else if ( timeP == 2 )
  {
    image(loadImage("placer2.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  else if ( timeP == 1 )
  {
    image(loadImage("placer1.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  else if ( timeP == 0 )
  {
    image(loadImage("placer0.png"), f * 34 + 1, r * 34 + 87);
  }
  
  if ( timeI == 3 && timeP < 0 )
  {
    image(loadImage("illegal3.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  else if ( timeI == 2 && timeP < 0 )
  {
    image(loadImage("illegal2.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  else if ( timeI == 1 && timeP < 0 )
  {
    image(loadImage("illegal1.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  else if ( timeI == 0 && timeP < 0 )
  {
    image(loadImage("illegal0.png"), f1 * 34 + 1, r1 * 34 + 87);
  }
  
  if ( game.isTsumi(true) )
  {
    
    text("White Wins!", 179, 239);
    noLoop();
  }
  else if ( game.isTsumi(false) )
  {
    
    text("Black Wins!", 179, 239);
    noLoop();
  }
  
  if ( game.isRepetition() )
  {
    
    text("Draw!", 179, 239);
    noLoop();
  }
}

void mousePressed()
{
  if ( first && mouseX < 304 && mouseY < 393 && mouseY > 85 )
  {
    
    f = mouseX / 35;
    r = ( mouseY - 85) / 35;
    first = !first;
    timeS = 3;
    
    if ( !doDr && key == '#' && keyPressed )
    {
      
      doDr = true;
    }
    doPr = false;
  }
  else if ( !first && mouseX < 304 && mouseY < 393 && mouseY > 85 )
  {
    
    f1 = mouseX / 35;
    r1 = ( mouseY - 85 ) / 35;
    if ( key == '*' && keyPressed )
    {
      
       doPr = true;
    }
    else if ( key != '#' && keyPressed )
    {
      
      details += "#" + key;
      doDr = true;
    }
    else
    {
      
      doPr = false;
    }
  
  if ( r > -1 && f > -1 && game.getB()[r][f] != null && !doDr )
  {
    
    if ( game.getB()[r][f].getName().indexOf("N ") > -1 && f1 - f < 0 )
    {
        
       details += "<";
    }
    else if ( game.getB()[r][f].getName().indexOf("N ") > -1 && f1 - f > 0 )
    {
        
       details += ">";
    }
    else if ( game.getB()[r][f].getName().indexOf("P") > -1 || game.getB()[r][f].getName().indexOf("G") > -1
      || game.getB()[r][f].getName().indexOf("S") > -1 || game.getB()[r][f].getName().indexOf("N+") > -1
      || game.getB()[r][f].getName().indexOf("L") > -1 || game.getB()[r][f].getName().indexOf("K") > -1
      || game.getB()[r][f].getName().indexOf("B") > -1 || game.getB()[r][f].getName().indexOf("R") > -1 )
    {
          
      if ( r1 - r > 0 && f1 - f == 0 )
      {
          
        details += "2";
          
        if ( game.getB()[r][f].getName().indexOf("R") > -1 || game.getB()[r][f].getName().indexOf("L ") > -1 )
        {
            
          details += "=" + ( r1 - r );
        }
      }
      else if ( r1 - r > 0 && f1 - f < 0 && abs(r1 - r) == abs(f1 - f) )
      {
          
        details += "1";
           
        if ( game.getB()[r][f].getName().indexOf("B") > -1 )
        {
              
          details += "=" + ( r1 - r );
        }
      }
      else if ( r1 - r > 0 && f1 - f > 0 && r1 - r == f1 - f)
      {
          
        details += "3";
        
        if ( game.getB()[r][f].getName().indexOf("B") > -1 )
        {   
          details += "=" + ( r1 - r );
        }
      }
      else if ( r1 - r == 0 && f1 - f > 0 )
      {
            
        details += "6";
            
        if ( game.getB()[r][f].getName().indexOf("R") > -1 )
        {
            
          details += "=" + ( f1 - f );
        }
      }
      else if ( r1 - r == 0 && f1 - f < 0 )
      {
          
        details += "4";
          
        if ( game.getB()[r][f].getName().indexOf("R") > -1 )
        {
              
          details += "=" + abs(f1 - f) ;
        }
      }
      else if ( f1 - f > 0 && r1 - r < 0 && abs(f1 - f) == abs(r1 - r) )
      {
           
        details += "9";
          
        if ( game.getB()[r][f].getName().indexOf("B") > -1 )
         {
             
           details += "=" + ( f1 - f );
        }
      }
      else if ( f1 - f == 0 && r1 - r < 0 )
      {
          
        details += "8";
          
        if ( game.getB()[r][f].getName().indexOf("R") > -1 || game.getB()[r][f].getName().indexOf("L ") > -1 )
        {
            
          details += "=" + abs(r1 - r);
        }
      }
      else if ( f1 - f < 0 && r1 - r < 0 && abs(f1 - f) == abs(r1 - r) )
      {
          
        details += "7";
       
        if ( game.getB()[r][f].getName().indexOf("B") > -1 )
        {
            
          details += "=" + abs(r1 - r);
        }
      }
    }
    if ( doPr )
    {
      details += "*";
      
    }
    doPr = false;
  }
  if ( doDr && details.charAt(0) == '#' )
  {
    
    if ( game.drop(r, f, turn, details.charAt(1) - 48 ) )
    {
        
      turn = !turn;
      timeP = 3;
    }
    else
    {
      timeI = 3;
    }
    doDr = !doDr;
    doPr = false;
  }
  else
  {
    int[] newCoords = game.move(r, f, details, turn);
    if ( newCoords[0] > -1 )
    {
        
      if ( details.charAt(details.length() - 1) == '*' )
      {
          game.promote(newCoords[0], newCoords[1]);
      }
      turn = !turn;
      timeP = 3;
      doPr = false;
    }
    else
    {
      timeI = 3;
      doPr = false;
    }
  }
  first = !first;
  doPr = false;
  /*r = -1;
  r1 = -1;
  f = -1;
  f1 = -1;*/
}
}    
/**
 * Handles what belongs to a player
 */
class Player   
{   

  private ArrayList<Piece> tray = new ArrayList<Piece>();   
  private ArrayList<Piece> army = new ArrayList<Piece>();   

  /**
   * Adds a piece to this side.
   *
   * @param  recruit  A Piece being added to this side.
   */
  public void addToArmy(Piece recruit)   
  {   

    army.add(recruit);
  }   
  
  /**
   * Take a piece from this side.
   *
   * @param  hostage  the one being taken away.
   */
  public Piece removeFromArmy(Piece hostage)   
  {   
    int i = 0;   

    while ( i < army.size() - 1 &&  army.get(i) != hostage )   
    {   

      i++;
    }   

    Piece abducted = army.get(i);   
    army.remove(i);   
    return abducted;
  }    
  
  /**
   * Adding to this side's tray.
   *
   * @param  captured  the one being added to the tray.
   *
   */
  public void addToTray(Piece captured)   
  {   

    tray.add(captured);
  }   
  
  /**
   * Taking away from tray to drop it unto the board.
   *
   * @param  deployed  position of piece to be dropped.
   * @return           Piece to be dropped.
   *
   */
  public Piece removeFromTray(int deployed)   
  {   

    return tray.remove(deployed);
  }   

  /**
   * Giving the army's size.
   *
   * @return    size of army
   *
   */
  public int getArmySize()   
  {   

    return army.size();
  }   
  /**
   * Return tray so it can be searched.
   *
   * @return    the tray.
   *
   */
  public ArrayList<Piece> getTray()   
  {   

    return tray;
  }
}

public class Board   
{   

  private Piece[][] shougi = new Piece[9][9];   
  private Player black = new Player();   
  private Player white = new Player();   
  ArrayList<Snapshot> memory = new ArrayList<Snapshot>();
  PImage boardImg = loadImage("boardDisp.png");
  PImage wSymbol = loadImage("isWhite.png");
  PImage bSymbol = loadImage("isBlack.png");
  
  /**
   * Create the board and fill it up and assign pieces to players.
   *
   */
  public Board()   
  {   

    for ( int i = 0; i < 9; i++ )   
    {   

      shougi[2][i] = new Pawn(false);
    }   

    for ( int i = 0; i < 9; i++ )   
    {   

      shougi[6][i] = new Pawn(true);
    }   
    shougi[0][0] = new Lance(false);   
    shougi[0][8] = new Lance(false);   
    shougi[8][0] = new Lance(true);   
    shougi[8][8] = new Lance(true);   
    shougi[0][1] = new Knight(false);   
    shougi[0][7] = new Knight(false);   
    shougi[8][1] = new Knight(true);   
    shougi[8][7] = new Knight(true);   
    shougi[0][2] = new Silver(false);   
    shougi[0][6] = new Silver(false);   
    shougi[8][2] = new Silver(true);   
    shougi[8][6] = new Silver(true);   
    shougi[0][3] = new Gold(false);   
    shougi[0][5] = new Gold(false);   
    shougi[8][3] = new Gold(true);   
    shougi[8][5] = new Gold(true);   
    shougi[0][4] = new King(false);   
    shougi[8][4] = new King(true);   
    shougi[1][1] = new Rook(false);   
    shougi[7][1] = new Bishop(true);   
    shougi[1][7] = new Bishop(false);   
    shougi[7][7] = new Rook(true);   

    for ( int i = 0; i < 9; i++ )   
    {   

      for ( int j = 0; j < 9; j++ )   
      {   

        if ( shougi[i][j] != null && shougi[i][j].isBlack() )   
        {   

          black.addToArmy(shougi[i][j]);
        }   
        else if ( shougi[i][j] != null )   
        {   

          white.addToArmy(shougi[i][j]);
        }
      }
    }   
    memory.add(new Snapshot(shougi, false, white.getTray(), black.getTray()));
  }   
  
  /**
   * Return board.
   *
   * @return    contents of board
   *
   */
  public Piece[][] getB()
  {
    
    return shougi;
  }
  
  /**
   * tries to drop a piece (won't if there is a pawn in the file,
   * or if it is at a spot the piece can't move from).
   *
   * @param  r  rank coordinate to drop upon
   * @param  f  file coordinate
   * @param  isB  whose turn it is
   * @param  pos  position in tray
   * @return    whether or not it could drop the piece
   *
   */
  public boolean drop(int r, int f, boolean isB, int pos) //returns if it was dropped.   
  {                                                       //r and f are target coordinates.   

    for ( int i = 0; i < 9; i++ )   
    {   

      if ( shougi[i][f] != null && shougi[i][f].isBlack() == isB    
        && shougi[i][f].getName().indexOf("P") > -1 && shougi[i][f].getName().indexOf("+") == -1 )   
      {   
        
        if ( black.getTray().size() > -1 && isB && black.getTray().get(pos - 1).getName().indexOf("P ") > -1 )
        {
          
          return false; //looking for pawns in the same file. If found, can't drop.
        }
        
        if ( white.getTray().size() > -1 && !isB && white.getTray().get(pos - 1).getName().indexOf("P ") > -1 )
        {
            
          return false;
        }
      }
    }   

    if ( shougi[r][f] == null )   
    {   

      if ( isB )   
      {   

        shougi[r][f] = black.removeFromTray(pos - 1);   
        memory.add(new Snapshot(shougi, isB, white.getTray(), black.getTray()));   
        return true;
      }   
      else   
      {   

        shougi[r][f] = white.removeFromTray(pos - 1);   
        memory.add(new Snapshot(shougi, isB, white.getTray(), black.getTray()));   
        return true;
      }
    }   
    return false;
  }   

  /**
   * moves a piece
   *
   * @param  r  original rank
   * @param  f  file
   * @param  dir  instructions on how to move
   * @param  isB  whose turn it is
   * @return    coordinates of new spot; or -1 to indicate move was
   *            illegal
   *
   */
  public int[] move(int r, int f, String dir, boolean isB) //r and f are original coordinates.   
  {   

    if ( !( r > -1 && r < 9 && f > -1 && f < 9 ) )   
    {   

      return new int[] {
        -1
      };
    }   

    if ( shougi[r][f] == null )
    {
      return new int[] { -1 };
    }
    if ( shougi[r][f].isBlack() == isB || !shougi[r][f].isBlack() == !isB )   
    {   

      int[] newPos = canMove(shougi[r][f], dir, r, f);   

      if ( newPos[0] != -1 )   
      {   

        if ( shougi[newPos[0]][newPos[1]] != null && shougi[newPos[0]][newPos[1]].getName().indexOf("K")    
          < 0 )   
        {   

          if ( shougi[newPos[0]][newPos[1]].isBlack() == shougi[r][f].isBlack() )   
          {   

            return new int[] {
              -1
            };
          }   
          capture(isB, shougi[r][f], shougi[newPos[0]][newPos[1]], newPos[0], newPos[1], r, f);   
          memory.add(new Snapshot(shougi, isB, white.getTray(), black.getTray()));   
          return new int[] {
            newPos[0], newPos[1]
          };
        }   
        shougi[newPos[0]][newPos[1]] = shougi[r][f];   
        shougi[r][f] = null;   
        memory.add(new Snapshot(shougi, isB, white.getTray(), black.getTray()));   
        return new int[] {
          newPos[0], newPos[1]
        };
      }   
      return new int[] {
        -1
      };
    }   
    return new int[] {
      -1
    };
  }   

  /**
   * gets a piece and puts it on the other side's tray.
   *
   * @param  isB  whose turn is it (black is true)
   * @param  victor  captor
   * @param  victim  piece being captured
   * @param  badR  captive's rank
   * @param  badF  captive's file
   * @param  r  captor's rank
   * @param  f  captor's file
   *
   */
  private void capture(boolean isB, Piece victor, Piece victim, int badR, int badF, int r, int f)   
  {   

    Piece temp = victim;   
    shougi[badR][badF] = victor;   
    temp.changeSide();   
    temp.promote(false);   

    if ( isB )   
    {   

      black.addToTray(temp);   
      white.removeFromArmy(temp);
    }   
    else   
    {   

      white.addToTray(temp);   
      black.removeFromArmy(temp);
    }   
    shougi[r][f] = null;
  } 
  
  /**
   * tells move() if a move is legal
   *
   * @param  moving  piece attempting to move
   * @param  instr  instructions on how to move
   * @param  r  original rank
   * @param  f  file
   * @return    new coordinates, or -1 if illegal
   *
   */
  private int[] canMove(Piece moving, String instr, int r, int f)   
  {   

    if ( instr.equals("") )   
    {   

      return new int[] {
        -1
      };
    }   
    int seek = 1;  //type of move.   
    int d = 0; //how much will move      
    boolean willPromote = false;   
    int direc = instr.charAt(0) - 48;   

    if ( instr.charAt(instr.length() - 1) == '*' )   
    {   

      willPromote = true;
    }    

    if ( instr.length() > 1 && instr.charAt(1) == '=' )   
    {   

      seek = 2;
    }   
    else if ( instr.charAt(0) == '<' )  //knight goes left   
    {   

      seek = 3;
    }   
    else if ( instr.charAt(0) == '>' )  //knight goes right   
    {   

      seek = 4;
    }   

    if ( willPromote && seek == 2)   
    {   

      d = instr.charAt(instr.length() - 2) - 48;
    }   
    else if ( seek == 2 )   
    {   

      d = instr.charAt(instr.length() - 1) - 48;
    }   
    else if ( seek == 1 )   
    {   

      d = 1;
    }   


    if ( seek == 3 )   
    {   

      if ( moving.isBlack() )   
      {   
        r -= 2;
      }   
      else   
      {   

        r += 2;
      }   
      f -= 1;
    }   
    else if ( seek == 4 )   
    {   

      if ( moving.isBlack() )   
      {   

        r -= 2;
      }   
      else   
      {   

        r += 2;
      }   
      f += 1;
    }//now to compare with the charts & see if piece is going over another piece:   
    else if ( direc == 8 && moving.getMoves().charAt(1) - 48 == seek )   
    {   

      for ( int i = r - 1; i > r - d; i-- )   
      {   

        if ( shougi[i][f] != null )   
        {   

          return new int[] {
            -1
          };
        }
      }   
      r -= d;
    }   
    else if ( direc == 9 && moving.getMoves().charAt(2) - 48 == seek)   
    {   

      int j = f + 1;   

      for ( int i = r - 1; i > r - d; i-- )   
      {   

        if ( shougi[i][j] != null )   
        {   

          return new int[] {
            -1
          };
        }   
        j++;
      }   
      r -= d;   
      f += d;
    }   
    else if ( direc == 6 && moving.getMoves().charAt(5) - 48 == seek )   
    {   

      for ( int i = f + 1; i < f + d; i++ )   
      {   

        if ( shougi[r][i] != null )   
        {   

          return new int[] {
            -1
          };
        }
      }   
      f += d;
    }  
    else if ( direc == 3 && moving.getMoves().charAt(8) - 48 == seek )   
    {   

      int j = f + 1;   

      for ( int i = r + 1; i < r + d; i++ )   
      {   

        if ( shougi[i][j] != null )   
        {   

          return new int[] {
            -1
          };
        }   
        j++;
      }   
      r += d;   
      f += d;
    }   
    else if ( direc == 2 && moving.getMoves().charAt(7) - 48 == seek )   
    {   

      for ( int i = r + 1; i < r + d; i++ )   
      {   

        if ( shougi[i][f] != null )   
        {   

          return new int[] {
            -1
          };
        }
      }   
      r += d;
    }   
    else if ( direc == 1 && moving.getMoves().charAt(6) - 48 == seek )   
    {   

      int j = f - 1;   

      for ( int i = r + 1; i < r + d; i++ )   
      {   

        if ( shougi[i][j] != null )   
        {   

          return new int[] {
            -1
          };
        }   
        j--;
      }   
      r += d;   
      f -= d;
    }   
    else if ( direc == 4 && moving.getMoves().charAt(3) - 48 == seek )   
    {   

      for ( int i = f - 1; i > f - d; i-- )   
      {   

        if ( shougi[r][i] != null )   
        {   
          
          return new int[] {
            -1
          };
        }
      }   
      f -= d;
    }   
    else if ( direc == 7 && moving.getMoves().charAt(0) - 48 == seek )   
    {   

      int j = f - 1;   

      for ( int i = r - 1; i > r - d; i-- )   
      {   

        if ( shougi[i][j] != null )   
        {   

          return new int[] {
            -1
          };
        }   
        j--;
      }   
      r -= d;   
      f -= d;
    }   

    if ( r > -1 && r < 9 && f > -1 && f < 9 )   
    {   
      if ( moving.getName().indexOf("L ") > -1 && ( ( r > 0 && moving.isBlack() && r < 9 ) || ( r < 8 && r > -1   
        && !moving.isBlack() ) ) || willPromote)   
      {   

        return new int[] {
          r, f
        };
      }   

      if ( moving.getName().indexOf("P ") > -1 && ( ( r > 0 && moving.isBlack() && r < 9 ) || ( r < 8 && r > -1   
        && !moving.isBlack() ) ) || willPromote )   
      {   

        return new int[] {
          r, f
        };
      }   

       if ( ( moving.getName().indexOf(" bN ") > -1 && seek == 3 && ( ( f > -1 && r > 1 && f < 9 && r < 9 ) || willPromote ) )
            || ( moving.getName().indexOf(" wN ") > -1 && seek == 3 && ( ( f > -1 && r > -1 && f < 9 && r < 7 ) || willPromote ) ) )  
         {   
            
            return new int[] {r, f};   
         }   
            
         if ( ( moving.getName().indexOf(" bN ") > -1 && seek == 4 && ( ( f < 9 && r > 1 && f > -1 && r < 9 ) || willPromote ) )
            || ( moving.getName().indexOf(" wN ") > -1 && seek == 4 && ( ( f < 9 && r > -1 && f > -1 && r < 7 ) || willPromote ) ) )  
         {   
             
            return new int[] {r, f};   
         }
      else if ( moving.getName().indexOf("L ")  < 0 && moving.getName().indexOf("N ") < 0   
        && moving.getName().indexOf("P ") < 0 )   
      {   

        return new int[] {
          r, f
        };
      }
    }   
    return new int[] {
      -1
    };
  }   

  /**
   * Displays board.
   *
   * @param isB  whose turn it is.
   *
   */
  public void show(boolean isB)   
  {   

    image(boardImg, 0, 0);

    for ( int i = 0; i < 9; i++ )
    {

      for ( int j = 0; j < 9; j++ )
      {

        if ( shougi[i][j] != null )
        {

          image(shougi[i][j].display(), j * 34 + 1, i * 34 + 87);
        }
      }
    }
    
    for ( int i = 0; i < white.getTray().size(); i++ )
    {
      
      if ( i < 11 )
      {
        
         image(white.getTray().get(i).display(), 1 + i * 34, 2);
      }
      else
      {
        
         image(white.getTray().get(i).display(),  1 + i * 34, 36);
      }
    }
    
    for ( int i = 0; i < black.getTray().size(); i++ )
    {
      
      if ( i < 11 )
      {
        
        image(black.getTray().get(i).display(), 1 + i * 34, 412);
      }
      else
      {
          
        image(white.getTray().get(i).display(), 1 + i * 34, 446);
      }
    }
    
    if ( isB )
    {
     
      image(bSymbol, 315, 223);
    }
    else
    {
      
      image(wSymbol, 315, 223);
    }  
  }   
  
  /**
   * promtes a piece
   *
   * @param  x  rank  
   * @param  y  file
   *
   */
  public void promote(int x, int y)   
  {   

    if ( shougi[x][y].isBlack() && x > -1 && x < 3 )   
    {   

      shougi[x][y].promote(true);
    }   
    else if ( !shougi[x][y].isBlack() && x > 5 && x < 9 )   
    {   

      shougi[x][y].promote(true);
    }
  }   
  
  /**
   * looks to see if a side is on check
   *
   * @param  isB  side to be verified for check
   * @return    whether or not there is check
   *
   */
  boolean isCheck(boolean isB)
   {
      
      Integer kR = new Integer(-1);
      Integer kF = new Integer(-1);
      
      for ( int i = 0; i < 9; i++ )
      {
      
         for ( int j = 0; j < 9; j++ )
         {
         
            if ( shougi[i][j] != null && shougi[i][j].getName().indexOf("K") > -1
               && shougi[i][j].isBlack() == isB )
            {
               
               kR = new Integer(i);
               kF = new Integer(j);
            }
         }
      }
      
      if ( isThreatened(kR.intValue(), kF.intValue(), isB)[0] > -1 )
      {
         
         return true;
      }
      return false;
   }
   
   /**
    * looks to see if a side is on checkmate
    *
    * @param  isB   side to be checked
    * @return      if there is checkmate or not
    *
    */
   boolean isTsumi(boolean isB) //checkmate or not: can be by normal checkmate or stalemate.
   {
   
      int kR = -1, kF = -1;
      int[][] zones = new int[3][3];
      int count = 0;
      
      for ( int i = 0; i < 9; i++ )
      {
      
         for ( int j = 0; j < 9; j++ )
         {
         
            if ( shougi[i][j] != null && shougi[i][j].getName().indexOf("K") > -1
               && shougi[i][j].isBlack() == isB )
            {
               
               kR = i;
               kF = j;
            }
         }
      }
      
      if ( kR > 0 && kF > 0 && ( ( shougi[kR - 1][kF - 1] != null && shougi[kR - 1][kF - 1].isBlack() == isB )
         || isThreatened(kR - 1, kF - 1, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR - 1][kF - 1] != null )
         {
         
            zones[0][0] = 1;
         }
         else if ( shougi[isThreatened(kR - 1, kF - 1, isB)[0]][isThreatened(kR - 1, kF - 1, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR - 1, kF - 1, isB)[0], isThreatened(kR - 1, kF - 1, isB)[1], isB)[0] == -1 )
         {
            zones[0][0] = 1;
         }  
      }
      
      if ( kR > 0 && ( ( shougi[kR - 1][kF] != null && shougi[kR - 1][kF].isBlack() == isB )
         || isThreatened(kR - 1, kF, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR - 1][kF] != null )
         {
         
            zones[0][1] = 1;
         }
         else if ( shougi[isThreatened(kR - 1, kF, isB)[0]][isThreatened(kR - 1, kF, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR - 1, kF, isB)[0], isThreatened(kR - 1, kF, isB)[1], isB)[0] == -1 )
         {
            zones[0][1] = 1;
         } 
      }
      
      if ( kR > 0 && kF < 8 && ( ( shougi[kR - 1][kF + 1] != null && shougi[kR - 1][kF + 1].isBlack() == isB )
         || isThreatened(kR - 1, kF + 1, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR - 1][kF + 1] != null )
         {
            
            zones[0][2] = 1;
         }
         else if ( shougi[isThreatened(kR - 1, kF + 1, isB)[0]][isThreatened(kR - 1, kF + 1, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR - 1, kF + 1, isB)[0], isThreatened(kR - 1, kF + 1, isB)[1], isB)[0] == -1 )
         {
            zones[0][2] = 1;
         } 
      }
      
      if ( kF > 0 && ( ( shougi[kR][kF - 1] != null && shougi[kR][kF - 1].isBlack() == isB )
         || isThreatened(kR, kF - 1, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR][kF - 1] != null )
         {
            zones[1][0] = 1;
         }
         else if ( shougi[isThreatened(kR, kF - 1, isB)[0]][isThreatened(kR, kF - 1, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR, kF - 1, isB)[0], isThreatened(kR, kF - 1, isB)[1], isB)[0] == -1 )
         {
            zones[1][0] = 1;
         } 
      }
      
      if ( kF < 8 && ( ( shougi[kR][kF + 1] != null && shougi[kR][kF + 1].isBlack() == isB )
         || isThreatened(kR, kF + 1, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR][kF + 1] != null )
         {
         
            zones[1][2] = 1;
         }
         else if ( shougi[isThreatened(kR, kF + 1, isB)[0]][isThreatened(kR, kF + 1, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR, kF + 1, isB)[0], isThreatened(kR, kF + 1, isB)[1], isB)[0] == -1 )
         {
            zones[1][2] = 1;
         } 
      }
      
      if ( kR < 8 && kF > 0 && ( ( shougi[kR + 1][kF - 1] != null && shougi[kR + 1][kF - 1].isBlack() == isB )
         || isThreatened(kR + 1, kF - 1, isB)[0] > -1 ) )
      {
      
         if ( shougi[kR + 1][kF - 1] != null )
         {
         
            zones[2][0] = 1;
         }
         else if ( shougi[isThreatened(kR + 1, kF - 1, isB)[0]][isThreatened(kR + 1, kF - 1, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR + 1, kF - 1, isB)[0], isThreatened(kR + 1, kF - 1, isB)[1], isB)[0] == -1)
         {
            zones[2][0] = 1;
         } 
      }
      
      if ( kR < 8 && ( ( shougi[kR + 1][kF] != null && shougi[kR + 1][kF].isBlack() == isB )
         || isThreatened(kR + 1, kF, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR + 1][kF] != null )
         { 
         
            zones[2][1] = 1;
         }
         else if ( shougi[isThreatened(kR + 1, kF, isB)[0]][isThreatened(kR + 1, kF, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR + 1, kF, isB)[0], isThreatened(kR + 1, kF, isB)[1], isB)[0] == -1)
         {
            zones[2][1] = 1;
         } 
      }
      
      if ( kR < 8 && kF < 8 && ( ( shougi[kR + 1][kF + 1] != null && shougi[kR + 1][kF + 1].isBlack() == isB )
         || isThreatened(kR + 1, kF + 1, isB)[0] > -1 ) )
      {
         
         if ( shougi[kR + 1][kF + 1] != null )
         {
            
            zones[2][2] = 1;
         }
         else if ( shougi[isThreatened(kR + 1, kF + 1, isB)[0]][isThreatened(kR + 1, kF + 1, isB)[1]].isBlack() != isB && isThreatened(isThreatened(kR + 1, kF + 1, isB)[0], isThreatened(kR + 1, kF + 1, isB)[1], isB)[0] == -1)
         {
            zones[2][2] = 1;
         } 
      }
      
      if ( kR < 1 )
      {
         
         zones[0][0] = 1;
         zones[0][1] = 1;
         zones[0][2] = 1;
      }
      
      if ( kR > 7 )
      {
      
         zones[2][0] = 1;
         zones[2][1] = 1;
         zones[2][2] = 1;
      }
      
      if ( kF < 1 )
      {
      
         zones[1][0] = 1;
      }
      
      if ( kF > 7 )
      {
      
         zones[1][2] = 1;
      }
      
      if ( zones[0][0] == 1 && zones[0][1] == 1 && zones[0][2] == 1 && zones[1][0] == 1 && zones[1][2] == 1
         && zones[2][0] == 1 && zones[2][1] == 1 && zones[2][2] == 1 )
      {
         
         if ( isB && black.getArmySize() == 1 )
         {
            
            return true;
         }
         
         if ( !isB && white.getArmySize() == 1 )
         {
         
            return true;
         }
         
         if ( ( isCheck(true) && isB == true ) || ( isCheck(false) && isB == false ) )
         {
            return true;
         }
      }
      return false;
   }
   
   /**
    * if a spot can be attacked from with the current layout of
    * pieces
    *
    * @param  r  rank
    * @param  f  file
    * @param  isB  which side this applies to
    * @return    coordinates of piece threatening that spot
    */
   int[] isThreatened(int r, int f, boolean isB)
   {
   
      int j = f - 1; //for when we're looking for bishops (later on).
   
      if ( r > 0 && shougi[r - 1][f] != null && shougi[r - 1][f].isBlack() != isB &&
         ( shougi[r - 1][f].getName().indexOf("G") > -1
         || shougi[r - 1][f].getName().indexOf("S+") > -1
        || shougi[r - 1][f].getName().indexOf("L+") > -1
        || shougi[r - 1][f].getName().indexOf("N+") > -1
        || shougi[r - 1][f].getName().indexOf("P+") > -1 
        || shougi[r - 1][f].getName().equals(" wS ") 
        || shougi[r - 1][f].getName().indexOf("B+") > -1 
        || shougi[r - 1][f].getName().indexOf("K") > -1
        || shougi[r - 1][f].getName().equals(" wP ") ) )
      {
   
         return new int[] {r - 1, f};
      }
         
      if ( r > 0 && f < 8 && shougi[r - 1][f + 1] != null && shougi[r - 1][f + 1].isBlack() != isB &&
         ( shougi[r - 1][f + 1].getName().equals(" wG ")
         || shougi[r - 1][f + 1].getName().equals("+wP+")
         || shougi[r - 1][f + 1].getName().equals("+wS+")
         || shougi[r - 1][f + 1].getName().equals("+wL+")
         || shougi[r - 1][f + 1].getName().equals("+wN+")
         || shougi[r - 1][f + 1].getName().indexOf("S ") > -1 
         || shougi[r - 1][f + 1].getName().indexOf("R+") > -1 
         || shougi[r - 1][f + 1].getName().indexOf("K") > -1 ) )
      {
      
         return new int[] {r - 1, f + 1};
      }
   
      if ( r > 0 && f > 0 && shougi[r - 1][f - 1] != null && shougi[r - 1][f - 1].isBlack() != isB &&
         ( shougi[r - 1][f - 1].getName().equals(" wG ")
          || shougi[r - 1][f - 1].getName().equals("+wP+")
          || shougi[r - 1][f - 1].getName().equals("+wS+") 
          || shougi[r - 1][f - 1].getName().equals("+wL+")
          || shougi[r - 1][f - 1].getName().equals("+wN+")
          || shougi[r - 1][f - 1].getName().indexOf("S ") > -1 
          || shougi[r - 1][f - 1].getName().indexOf("R+") > -1
          || shougi[r - 1][f - 1].getName().indexOf("K") > -1 ) )
      {
   
         return new int[] {r - 1, f - 1};
      }
   
      if ( f > 0 && shougi[r][f - 1] != null && shougi[r][f - 1].isBlack() != isB &&
         ( shougi[r][f - 1].getName().indexOf("G") > -1
         || shougi[r][f - 1].getName().indexOf("P+") > -1
         || shougi[r][f - 1].getName().indexOf("G") > -1
         || shougi[r][f - 1].getName().indexOf("L+") > -1
         || shougi[r][f - 1].getName().indexOf("S+") > -1
         || shougi[r][f - 1].getName().indexOf("N+") > -1
         || shougi[r][f - 1].getName().indexOf("B+") > -1
         || shougi[r][f - 1].getName().indexOf("K") > -1 ) )
      {
   
         return new int[] {r, f - 1};
      }
   
      if ( f < 8 && shougi[r][f + 1] != null && shougi[r][f + 1].isBlack() != isB &&
         ( shougi[r][f + 1].getName().indexOf("G") > -1
         || shougi[r][f + 1].getName().indexOf("P+") > -1
         || shougi[r][f + 1].getName().indexOf("G") > -1
         || shougi[r][f + 1].getName().indexOf("L+") > -1
         || shougi[r][f + 1].getName().indexOf("N+") > -1
         || shougi[r][f + 1].getName().indexOf("S+") > -1
         || shougi[r][f + 1].getName().indexOf("B+") > -1 
         || shougi[r][f + 1].getName().indexOf("K") > -1 ) )
      {
      
         return new int[] {r, f + 1};
      }
   
      if ( r < 8 && f > 0 && shougi[r + 1][f - 1] != null && shougi[r + 1][f - 1].isBlack() != isB &&
         ( shougi[r + 1][f - 1].getName().equals(" bG ") 
         || shougi[r + 1][f - 1].getName().equals("+bP+")
         || shougi[r + 1][f - 1].getName().equals("+bN+")
         || shougi[r + 1][f - 1].getName().equals("+bL+")
         || shougi[r + 1][f - 1].getName().equals("+bS+")
         || shougi[r + 1][f - 1].getName().indexOf("S ") > -1
         || shougi[r + 1][f - 1].getName().indexOf("R+") > -1
         || shougi[r + 1][f - 1].getName().indexOf("K") > -1 ) )
      {
    
         return new int[] {r + 1, f - 1};
      }
     
      if ( r < 8 && f > 0 && shougi[r + 1][f - 1] != null && shougi[r + 1][f - 1].isBlack() != isB &&
         ( shougi[r + 1][f - 1].getName().indexOf("G") > -1
         || shougi[r + 1][f - 1].getName().indexOf("P+") > -1
         || shougi[r + 1][f - 1].getName().indexOf("G") > -1
         || shougi[r + 1][f - 1].getName().indexOf("L+") > -1
         || shougi[r + 1][f - 1].getName().indexOf("N+") > -1
         || shougi[r + 1][f - 1].getName().indexOf("S+") > -1 
         || shougi[r + 1][f - 1].getName().equals(" bS ")
         || shougi[r + 1][f - 1].getName().indexOf("B+") > -1
         || shougi[r + 1][f - 1].getName().equals(" bP ")
         || shougi[r + 1][f - 1].getName().indexOf("K") > -1 ) )
      {
      
         return new int[] {r + 1, f - 1};
      }
   
      if ( r < 8 && f < 8 && shougi[r + 1][f + 1] != null && shougi[r + 1][f + 1].isBlack() != isB &&
         ( shougi[r + 1][f + 1].getName().equals(" bG ")
         || shougi[r + 1][f + 1].getName().equals("+bP+")
         || shougi[r + 1][f + 1].getName().equals("+bL+")
         || shougi[r + 1][f + 1].getName().equals("+bN+")
         || shougi[r + 1][f + 1].getName().equals("+bS+")
         || shougi[r + 1][f + 1].getName().indexOf("S ") > -1
         || shougi[r + 1][f + 1].getName().indexOf("R+") > -1
         || shougi[r + 1][f + 1].getName().indexOf("K") > -1 ) )
      {
      
         return new int[] {r + 1, f + 1};
      }
   
      for ( int i = r - 1; i > -1 && ( i == r - 1 || shougi[i + 1][f] == null ); i-- ) //rooks & lances above.
      {
   
         if ( shougi[i][f] != null && shougi[i][f].isBlack() != isB && ( shougi[i][f].getName().indexOf("R") > -1
            || shougi[i][f].equals(" wL ") ) )
         {
         
            return new int[] {i, f};
         }
      }
      
      for ( int i = r + 1; i < 9 && ( i == r + 1 || shougi[i - 1][f] == null ); i++ ) //rooks below.
      {
         
         if ( shougi[i][f] != null && shougi[i][f].isBlack() != isB && ( shougi[i][f].getName().indexOf("R") > -1
            || shougi[i][f].equals(" bL ") ) )
         {
         
            return new int[] {i, f};
         }
      }
      
      for ( int i = f - 1; i > -1 && ( i == f - 1 || shougi[r][i + 1] == null ); i-- )   //rooks to the left. 
      {
      
         if ( shougi[r][i] != null && shougi[r][i].isBlack() != isB && shougi[r][i].getName().indexOf("R") > - 1 )  
         {
         
            return new int[] {r, i};
         }
      }                 
      
      for ( int i = f + 1; i < 9 && ( i == f + 1 || shougi[r][i - 1] == null ); i++ )    //rooks to the right.
      {
      
         if ( shougi[r][i] != null && shougi[r][i].isBlack() != isB && shougi[r][i].getName().indexOf("R") > -1 )
         {
         
            return new int[] {r, i};
         }
      }            
      
      for ( int i = r - 1; i > -1 && j > -1 && ( i == r - 1 || shougi[i + 1][j + 1] == null ); i-- ) //bishops top-left.
      {
         
         if ( shougi[i][j] != null && shougi[i][j].isBlack() != isB && shougi[i][j].getName().indexOf("B") > -1 )
         {
         
            return new int[] {i, j};
         }
         j--;
      }
      j = f + 1;
      
      for ( int i = r - 1; i > -1 && j < 9 && ( i == r - 1 || shougi[i + 1][j - 1] == null ); i-- ) //bishops top-right.
      {
      
         if ( shougi[i][j] != null && shougi[i][j].isBlack() != isB && shougi[i][j].getName().indexOf("B") > -1 )
         {
         
            return new int[] {i, j};
         }
         j++;
      }
      j = f - 1;
      
      for ( int i = r + 1; i < 9 && j > -1 && ( i == r + 1 || shougi[i - 1][j + 1] == null ); i++ ) //bishops bottom-left.          
      {
      
         if ( shougi[i][j] != null && shougi[i][j].isBlack() != isB && shougi[i][j].getName().indexOf("B") > -1 )
         {
         
            return new int[] {i, j};
         }
         j--;
      }
      j = f + 1;
         
      for ( int i = r + 1; i < 9 && j < 9 && ( i == r + 1 || shougi[i - 1][j - 1] == null ); i++ ) // bishops bottom-right.
      {
      
         if ( shougi[i][j] != null && shougi[i][j].isBlack() != isB && shougi[i][j].getName().indexOf("B") > -1 )
         {
         
            return new int[] {i, j};
         }
         j++;
      }
      
      if ( r > 1 && f > 0 && shougi[r - 2][f - 1] != null && shougi[r - 2][f - 1].getName().equals(" wN ") ) 
      {
         
         return new int[] {r - 2, f - 1};
      }
      
      if ( r > 1 && f < 8 && shougi[r - 2][f + 1] != null && shougi[r - 2][f + 1].getName().equals(" wN ") )
      {
         
         return new int[] {r - 2, f + 1};
      }
      
      if ( r < 7 && f > 0 && shougi[r + 2][f - 1] != null && shougi[r + 2][f - 1].getName().equals(" wN ") )
      {
      
         return new int[] {r + 2, f - 1};
      }
      
      if ( r < 7 && f < 8 && shougi[r + 2][f + 1] != null && shougi[r + 2][f + 1].getName().equals(" wN ") )
      {
      
         return new int[] {r + 2, f + 1};
      }
      return new int[] { -1 };
   }        
  
  /**
   * detects sennichite (four-fold repetition)
   * 
   * @return    if there is sennichite or not
   *
   */
  public boolean isRepetition()   
  {   

    int count = 0;   

    for ( int i = 0 ; i < memory.size(); i++ )   
    {   

      for ( int j = 0; j < memory.size(); j++ )   
      {   

        if ( memory.get(i).equals(memory.get(j)) )   
        {   

          count++;
        }
      }   

      if ( count == 4 )   
      {   

        return true;
      }   
      else   
      {   

        count = 0;
      }
    }   
    return false;
  }
}  

public interface Piece
{
  
  /**
   * used to verify side
   *
   * @return    if black (true) or white (false)
   *
   */
  boolean isBlack();
  /**
   * returns identifier
   *
   * @return    a tag showing type, promotional status, and side
   *
   */
  String getName();
  /**
   * shows if a piece extends the Promotable class
   *
   * @return    promotes or not
   *
   */
  boolean isPromotable();
  /**
   * promtes or demotes a piece
   *
   * @param  status  whether or not you want a piece to be promoted
   *
   */
  void promote(boolean status);
  /**
   * change a piece's side (for when it's captured)
   *
   */
  void changeSide();
  /**
   * retrieve a chart in the form of a string to see how a piece
   * can move
   *
   * @return    piece's moves
   *
   */
  String getMoves();
  /**
   * display itself
   *
   * @return    a png file (depending on side & promotion)
   *
   */
  PImage display();
}

abstract class Promotable implements Piece   
{   

  private boolean isPromoted;   
  private PImage look, pLook, mLook, mpLook;     

  abstract boolean isBlack(); 
  
  /**
   *  set png images for when its white or black, promoted or not
   *
   *  @param face  black
   *  @param face2  black promoted
   *  @param face3  white
   *  @param face4  white promoted
   *
   */
  void setLooks(PImage face, PImage face2, PImage face3, PImage face4)
  {
    
    look = face;
    pLook = face2;
    mLook = face3;
    mpLook = face4;
  }

  PImage display()
  {
    
    if ( isBlack() )
    {
      
      if ( isPromoted() ) 
      {

        return pLook;
      }
      return look;
    }
    
    if ( isPromoted() )
    {
        
      return mpLook;
    }
    return mLook;
  }

  boolean isPromotable()   
  {   

    return true;
  }   

  abstract String getName();   

  boolean isPromoted()   
  {   
    return isPromoted;
  }   

  void promote(boolean status)   
  {   

    isPromoted = status;
  }   

  abstract String getMoves(); //display possible moves   

  void changeSide()   
  {
    
  }
}  

public class Pawn extends Promotable   
{   

  private boolean alleg;   

  public Pawn(boolean side)   
  {   

    alleg = side;   
    super.promote(false);   
    super.setLooks(loadImage("p.png"), loadImage("p+.png"), loadImage("mp.png"), loadImage("mp+.png"));
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public String getName()   
  {   

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   

        return "+bP+";
      }   
      return " bP ";
    }   
    if ( super.isPromoted() )   
    {   

      return "+wP+";
    }   
    return " wP ";
  }   

  public String getMoves()   
  {   

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   
        return "111"   
          + "101"   
          + "010";
      }   
      return "010"   
        + "000"   
        + "000";
    }   
    if ( super.isPromoted() )   
    {   
      return "010"   
        + "101"   
        + "111";
    }   
    return "000"   
      + "000"   
      + "010";
  }   

  public void changeSide()   
  {   

    alleg = !alleg;
  }
}  

public class Rook extends Promotable   
{   

  private boolean alleg;   


  public Rook(boolean side)   
  {    

    alleg = side;   
    super.promote(false); 
    super.setLooks(loadImage("r.png"), loadImage("r+.png"), loadImage("mr.png"), loadImage("mr+.png"));
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public String getName()   
  {   

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   

        return "+bR+";
      }   
      return " bR ";
    }   

    if ( super.isPromoted() )   
    {   

      return "+wR+";
    }   
    return " wR ";
  }   

  public String getMoves()   
  {   

    if ( super.isPromoted() )   
    {   

      return "121"   
        + "202"   
        + "121";
    }   
    return "020"   
      + "202"   
      + "020";
  }   

  public void changeSide()   
  {   

    alleg = !alleg;
  }
}  

public class Silver extends Promotable   
{   

  private boolean alleg;   

  public Silver(boolean side)   
  {   

    alleg = side;   
    super.promote(false);   
    super.setLooks(loadImage("s.png"), loadImage("s+.png"), loadImage("ms.png"), loadImage("ms+.png"));
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public String getName()   
  {   

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   

        return "+bS+";
      }   
      return " bS ";
    }   

    if ( super.isPromoted() )   
    {   

      return "+wS+";
    }   
    return " wS ";
  }   

  public String getMoves()   
  {   

    if ( isBlack() )   
    { 

      if ( super.isPromoted() )   
      {   

        return "111"   
          + "101"   
          + "010";
      }   
      return "111"   
        + "000"   
        + "101";
    }   

    if ( super.isPromoted() )   
    {   

      return "010"   
        + "101"   
        + "111";
    }   
    return "101"   
      + "000"   
      + "111";
  }   

  public void changeSide()   
  {   

    alleg = !alleg;
  }
}  

public class Lance extends Promotable   
{   

  private boolean alleg;   

  public Lance(boolean side)   
  {   

    alleg = side;   
    super.promote(false);  
    super.setLooks(loadImage("l.png"), loadImage("l+.png"), loadImage("ml.png"), loadImage("ml+.png"));
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public String getName()   
  {           

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   

        return "+bL+";
      }   
      return " bL ";
    }   

    if ( super.isPromoted() )   
    {   

      return "+wL+";
    }   
    return " wL ";
  }   

  public String getMoves()   
  {   

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   

        return "111"   
          + "101"   
          + "010";
      }   
      return "020"   
        + "000"   
        + "000";
    }   

    if ( super.isPromoted() )   
    {   

      return "010"   
        + "101"   
        + "111";
    }   
    return "000"   
      + "000"   
      + "020";
  }   

  public void changeSide()   
  {   

    alleg = !alleg;
  }
}

public class Knight extends Promotable   
{   

  private boolean alleg;   

  public Knight(boolean side)   
  {   

    alleg = side;   
    super.promote(false);   
    super.setLooks(loadImage("n.png"), loadImage("n+.png"), loadImage("mn.png"), loadImage("mn+.png"));
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public String getName()   
  {   

    if ( isBlack() )   
    {   

      if ( super.isPromoted() )   
      {   

        return "+bN+";
      }   
      return " bN ";
    }   

    if ( super.isPromoted() )   
    {   

      return "+wN+";
    }   
    return " wN ";
  }   

  public String getMoves()   
  {   

    if ( isBlack() )   
    {   
      if ( super.isPromoted() )   
      {   

        return "111"   
          + "101"   
          + "010";
      }   
      return "304"   
        + "000"   
        + "000";
    }   

    if ( super.isPromoted() )   
    {   

      return "010"   
        + "101"   
        + "111";
    }   
    return "000"   
      + "000"   
      + "304";
  }     


  public void changeSide()   
  {   

    alleg = !alleg;
  }
}  

public class King implements Piece   
{   

  private boolean alleg;      
  private PImage look, mLook;  

  public King(boolean side)   
  {   

    alleg = side;   
    look = loadImage("k.png");
    mLook = loadImage("mk.png");
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public boolean isPromotable()   
  {   

    return false;
  }   

  public void promote(boolean status)   
  {
  }   

  public String getMoves()   
  {   

    return "111"   
      + "101"   
      + "111";
  }   

  public String getName()   
  {   

    if ( isBlack() )   
    {   

      return " bK ";
    }   
    return " wK ";
  } 

  public void changeSide()   
  {   

    alleg = !alleg;
  }   

  public PImage display()
  {

    if ( isBlack() )
    {
       return look;
    }
    return mLook;
  }  
}
public class Gold implements Piece   
{   

  private boolean alleg;   
  private PImage look, mLook; 

  public Gold(boolean side)   
  {   

    alleg = side;   
    look = loadImage("g.png");
    mLook = loadImage("mg.png");
  }   

  public boolean isBlack()   
  {   

    return alleg;
  }   

  public boolean isPromotable()   
  {   

    return false;
  }   

  public void promote(boolean status)   
  {
    
  }   

  public String getMoves()   
  {   

    if ( isBlack() )   
    {   
     return "111"   
          + "101"   
          + "010";
    }   
     return "010"   
          + "101"   
          + "111";
  }   

  public String getName()   
  {   

    if ( isBlack() )   
    { 

      return " bG ";
    }   
    return " wG ";
  }   

  public void changeSide()   
  {   

    alleg = !alleg;
  }   

  public PImage display()
  {
    
    if ( isBlack() )
    {
        
      return look;
    }
    return mLook;
  }
}  

class Bishop extends Promotable
{   
      
   private boolean alleg;   
      
   Bishop(boolean side)   
   {   
         
      alleg = side;   
      super.promote(false);   
      super.setLooks(loadImage("b.png"), loadImage("b+.png"), loadImage("mb.png"), loadImage("mb+.png"));
   }   
      
   boolean isBlack()   
   {   
         
      return alleg;   
   }   
      
   String getName()   
   {   
        
      if ( isBlack() )   
      {   
            
         if ( super.isPromoted() )   
         {   
               
            return "+bB+";   
         }   
         return " bB ";   
      }   
         
      if ( super.isPromoted() )   
      {   
            
         return "+wB+ ";   
      }   
      return " wB ";   
   }   
      
   String getMoves()   
   {   
         
      if ( super.isPromoted() )   
      {   
            
         return "212"   
              + "101"   
              + "212";   
      }   
      return "202"   
           + "000"   
           + "202";   
   }   
      
   void changeSide()   
   {   
         
      alleg = !alleg;   
   }   
}   
           


public class Snapshot    
{    

  private Piece[][] sBoard = new Piece[9][9];    
  private boolean isBTurn;    
  private ArrayList<Piece> wTray = new ArrayList<Piece>();    
  private ArrayList<Piece> bTray = new ArrayList<Piece>();     
  
  public Snapshot(Piece[][] g, boolean turn, ArrayList<Piece> wT, ArrayList<Piece> bT)    
  {    

    Piece k;    

    for ( int i = 0; i < 9; i++ )    
    {    

      for ( int j = 0; j < 9; j++ )    
      {    
        if ( g[i][j] != null )    
        {    

          sBoard[i][j] = copyPiece(g[i][j], g[i][j].getName().indexOf("+") > -1);
        }
      }
    }    
    isBTurn = turn;    

    for ( int i = 0; i < wT.size(); i++ )    
    {    
        
      wTray.add(copyPiece(wT.get(i), false));
    }    

    for ( int i = 0; i < bT.size(); i++ )    
    {    

      bTray.add(copyPiece(bT.get(i), false));
    }
  }    
  
  /**
   * sees if one position equals another
   *
   * @param other  a snapshot
   * @return    if this snapshot matches other
   *
   */
  public boolean equals(Snapshot other)    
  {    

    int counter = 0;    

    for ( int i = 0; i < 9; i++ ) //check position.    
    {    

      for ( int j = 0; j < 9; j++ )    
      {    

        if ( sBoard[i][j] != null && other.sBoard[i][j] != null    
          && sBoard[i][j].getName().equals(other.sBoard[i][j].getName()) )    
        {    

          counter++;
        }    
        else if ( sBoard[i][j] == null && other.sBoard[i][j] == null)    
        {    

          counter++;
        }
      }
    }    

    if ( counter != 81 )    
    {    

      return false;
    }    

    if ( isBTurn != other.isBTurn ) //check who's playing.    
    {    

      return false;
    }    

    if ( wTray.size() == other.wTray.size() && bTray.size() == other.bTray.size() )    
    {//check trays.    

      for ( int i = 0; i < wTray.size(); i++ )    
      {    

        if ( !wTray.get(i).getName().equals(other.wTray.get(i).getName()) )    
        {    

          return false;
        }
      }    

      for ( int i = 0; i < bTray.size(); i++ )    
      {    

        if ( !bTray.get(i).getName().equals(other.bTray.get(i).getName()) )    
        {    

          return false;
        }
      }
    }    
    return true;
  }    

  /**
   * duplicate a piece
   *
   * @param inGame  piece to copy
   * @param isPromoted  whether or not piece has been promoted
   * @return    the duplicated piece
   *
   */
  private Piece copyPiece(Piece inGame, boolean isPromoted)    
  {    

    Piece a;    

    if ( inGame.getName().indexOf("K") > -1 )    
    {    

      a = new King(inGame.isBlack());
    }    
    else if ( inGame.getName().indexOf("G") > -1 )    
    {    

      a = new Gold(inGame.isBlack());
    }    
    else if ( inGame.getName().indexOf("S") > -1 )    
    {    

      a = new Silver(inGame.isBlack());
    }    
    else if ( inGame.getName().indexOf("N") > -1 )    
    {    

      a = new Knight(inGame.isBlack());
    }    
    else if ( inGame.getName().indexOf("L") > -1 )    
    {    

      a = new Lance(inGame.isBlack());
    }      
    else if ( inGame.getName().indexOf("B") > -1 )    
    {    

      a = new Bishop(inGame.isBlack());
    }    
    else if ( inGame.getName().indexOf("R") > -1 )    
    {    

      a = new Rook(inGame.isBlack());
    }    
    else    
    {    

      a = new Pawn(inGame.isBlack());
    }     

    if ( isPromoted )    
    {    

      a.promote(true);
    }    
    return a;
  }
}

