import requests
import csv
import time

def getPrices(start_lat, start_lng, end_lat, end_lng):
  url = 'https://sandbox-api.uber.com/v1/estimates/price'

  parameters = {
    'server_token': 'TSpAqrf0np3YxP-zvd3KxxfXTEUVv6Z27ISbhslU',
    'end_latitude': end_lat,
    'end_longitude': end_lng,
    'start_latitude': start_lat,
    'start_longitude': start_lng
  }

  response = requests.get(url, params=parameters)

  data = response.json()

  return data['prices']

# print getPrices(37.785144, -122.406677, 37.625732, -122.377807)

# csvin  = './SFO.csv'
# csvout = './SFO_prices.csv'

# SFO_lat = 37.625732
# SFO_lng = -122.377807

#with open(csvout, 'wb') as csvfile:
#    outwriter = csv.writer(csvfile, delimiter=',',
#                            quotechar="'", quoting=csv.QUOTE_MINIMAL)
#    outwriter.writerow(["id","rating","proximity","latitude","longitude","lowprice","highprice"])
#
#    with open(csvin, 'rb') as csvfile:
#      sforeader = csv.DictReader(csvfile)
#      for row in sforeader:
#        print row
#        prices = getPrices(SFO_lat, SFO_lng, row['latitude'], row['longitude'])
#        pricedict = {"low":0,"high":0}
#        for pricedata in prices:
#          if pricedata['localized_display_name'] == "uberX":
#            pricedict["low"] = pricedata["low_estimate"]
#            pricedict["high"] = pricedata["high_estimate"]
#            newrow = [row["id"],row["rating"],row["proximity"],row["latitude"],row["longitude"],pricedict["low"],pricedict["high"]]
#            print newrow
#            outwriter.writerow(newrow)
#        time.sleep(2)

csvin  = './SJC.csv'
csvout = './SJC_prices.csv'

SJC_lat = 37.3628
SJC_lng = -121.9292

with open(csvout, 'wb') as csvfile:
    outwriter = csv.writer(csvfile, delimiter=',',
                            quotechar="'", quoting=csv.QUOTE_MINIMAL)
    outwriter.writerow(["id","rating","proximity","latitude","longitude","lowprice","highprice"])

    with open(csvin, 'rb') as csvfile:
      sforeader = csv.DictReader(csvfile)
      for row in sforeader:
        print row
        prices = getPrices(SJC_lat, SJC_lng, row['latitude'], row['longitude'])
        pricedict = {"low":0,"high":0}
        for pricedata in prices:
          if pricedata['localized_display_name'] == "uberX":
            pricedict["low"] = pricedata["low_estimate"]
            pricedict["high"] = pricedata["high_estimate"]
            newrow = [row["id"],row["rating"],row["proximity"],row["latitude"],row["longitude"],pricedict["low"],pricedict["high"]]
            print newrow
            outwriter.writerow(newrow)
        time.sleep(2)
