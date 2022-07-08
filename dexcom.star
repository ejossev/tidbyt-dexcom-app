load("render.star", "render")
load("http.star", "http")
load("time.star", "time")

#Fill these fields.
#TODO: use schema module (https://github.com/tidbyt/pixlet/blob/main/docs/schema/schema.md) instead
ACCOUNT_ID=""
ACCOUNT_PWD=""


APPLICATION_ID="d89443d2-327c-4a6f-89e5-496bbb0317db"
LOGIN_URL='https://shareous1.dexcom.com/ShareWebServices/Services/General/LoginPublisherAccountById'
FETCH_URL="https://shareous1.dexcom.com//ShareWebServices/Services/Publisher/ReadPublisherLatestGlucoseValues"

def fetchData():
   body={ "accountId": ACCOUNT_ID, "password": ACCOUNT_PWD, "applicationId": APPLICATION_ID}
   rep = http.post(LOGIN_URL, headers={"Content-Type": "application/json"}, json_body=body)
   if rep.status_code != 200:
       fail("Dexcom login failed with status %d", rep.status_code)
   sessionId = rep.json()

   rep = http.get(FETCH_URL + "?sessionID=" + sessionId + "&minutes=100&maxCount=2")
   if rep.status_code != 200:
       fail("Dexcom fetch failed with status %d", rep.status_code)
   data = rep.json()
   return data

def flToStr(fl, addSign=False):
   sign = "+" if addSign else ""
   if fl < 0:
     fl = -fl
     sign = "-"
   flI = int(fl)
   flD = int(10*(fl - flI))

   return "%s%d.%d" % (sign, flI, flD)

def parseData(data):
   if len(data) == 0:
      return "NO DATA", "", "0xf00"
   current = data[0]["Value"] / 18
   currentTS = int(data[0]["WT"][5:-1])/1000
   now = time.now()
   color = "#f00" if current > 9 or current < 4 else "#0f4"

   data_age = now.unix - currentTS
   if data_age > 360:
      return flToStr(current), "%dm old" % int(data_age/60), color

   delta = 0
   print(len(data))
   if len(data) == 2:
      delta = (data[0]["Value"] - data[1]["Value"]) / 18

   return flToStr(current), flToStr(delta, True), color

def main():
   data = fetchData()
   current, delta, color = parseData(data)
   return render.Root(
      child = render.Row(
          children=[
             render.Text("%s"  % (current), color=color, font="10x20"),
             render.Text(" (%s)" % (delta))
          ],
          cross_align="center"
      ),
      max_age = 10

   )
   


