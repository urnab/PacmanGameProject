class Lines
{
  void drawLines()
  {
    stroke(255); // White lines
  
    for(int j = 0; j <= height; j += 40)
    {
      for(int i = 0; i < width; i += 40)
      {
        fill(0); 
        rect(i, j, 40, 40);
      }
    }
  }
}
