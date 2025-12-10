function InfoText(player,Ntxt,time,r,g,b)
 triggerClientEvent(player,"InfoText",player,Ntxt,time,r,g,b)
end


function TutoText(player,Ttxt,time)
  triggerClientEvent(player,"TutoText",player,Ttxt,time)
end


function MissionText(player,state,mony)
  triggerClientEvent(player,"MissionPassed",player,state,mony)
end