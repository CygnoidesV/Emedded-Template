void serial (void)
{
   if (!Received)
   {
      TmoCount = 0;
      switch (Buff)
      {
         case AISGFLG:
            if ((TiBuff.Count > 3)
            && ((TiBuff.Buff[0] == 0xff) || (TiBuf.Buff[0] == CurPa.ADDR)))
            {//串口收到的数据 符合校验规则
               Flg7E = false;
               Received = true;
            }
            else
            {
               TiBuff.Count = 0;
               Flg7D = false;
               Flg7E = true;
            }
            break;
         default:
            break;
      }
   }
}
