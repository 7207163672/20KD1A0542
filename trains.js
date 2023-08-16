const express = require('express');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());


app.get('/trains', async (req, res) => {
  try {
    const trains = await fetchTrainData();
    const trainsWithAvailability = await fetchSeatAvailability(trains);

    res.json(trainsWithAvailability);
  } catch (error) {
    res.status(500).json({ error: 'An error occurred.' });
  }
});
app.get('/trains/:id', async (req, res) => {
    try {
      const trainId = parseInt(req.params.id);
      const train = await fetchTrainDataById(trainId);
  
      if (train) {
        const trainWithAvailability = await fetchSeatAvailability([train]);
        res.json(trainWithAvailability[0]);
      } else {
        res.status(404).json({ error: 'Train not found.' });
      }
    } catch (error) {
      res.status(500).json({ error: 'An error occurred.' });
    }
  });
  
  async function fetchTrainDataById(trainId) {
    
    const response = await axios.get(`http://20.244.56.144/train/trains/${trainId}`);
    return response.data;
    return trains.find(train => train.id === trainId);
  }

  