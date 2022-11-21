DECLARE

   x INTEGER := 1;
   y INTEGER := 1;
   dir varchar := 'NORTH';
   step  VARCHAR(1);
   cont integer := 1;
   endplateaux integer;
   endplateauy integer;

BEGIN

   endplateaux := substr(plateau,1,1)::integer;
   endplateauy := substr(plateau,1,1)::integer;   

   RAISE NOTICE 'Plateau: %X% ',endplateaux,endplateauy;

   RAISE NOTICE 'Path: %',path;

   cont := 1;
   LOOP

      raise notice 'counting: %',cont;
      step := substr(path,cont,1);

      RAISE NOTICE 'step: %',step;

      EXIT WHEN COALESCE(step,'') = '';

      RAISE NOTICE 'Before %,%,%',x,y,dir;

      IF step = 'L' THEN
         
         dir := CASE WHEN dir = 'NORTH' THEN 'WEST' 
                     WHEN dir = 'WEST' THEN 'SOUTH'
                     WHEN dir = 'SOUTH' THEN 'EAST'
                     WHEN dir = 'EAST' THEN 'NORTH'
                     END;
      ELSIF step = 'R' THEN
         dir := CASE WHEN dir = 'NORTH' THEN 'EAST' 
                     WHEN dir = 'EAST' THEN 'SOUTH'
                     WHEN dir = 'SOUTH' THEN 'WEST'
                     WHEN dir = 'WEST' THEN 'NORTH'
                     END;
      ELSIF step = 'F' THEN
         IF dir = 'NORTH' THEN
            y := y + 1;
         ELSIF dir = 'EAST' THEN
            x := x + 1;
         ELSIF dir = 'WEST' THEN
            x := x - 1;  
         ELSIF dir = 'SOUTH' THEN
            y := y - 1;
         END IF;
      END IF;

      RAISE NOTICE 'After %,%,%',x,y,dir;

      IF x >= endplateaux THEN 
         x := endplateaux;
      END IF;

      IF y >= endplateauy THEN
        y := endplateauy;
      END IF;

      cont := cont + 1;

   END LOOP;

   RETURN x::varchar || ',' || y::varchar || ',' || dir;

END