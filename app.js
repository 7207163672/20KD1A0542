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


app.post('/register', async (req, res) => {
    try {
      const trainData = req.body; 
      const registrationStatus = await registerTrainData(trainData);
  
      if (registrationStatus.success) {
        res.json({ message: 'Train data registered successfully.' });
      } else {
        res.status(500).json({ error: 'Train data registration failed.' });
      }
    } catch (error) {
      res.status(500).json({ error: 'An error occurred.' });
    }
  });
  
  async function registerTrainData(trainData) {
    try {
      
    const response = await axios.post('http://20.244.56.144/train/register', trainData);
       return response.data;
      
    } catch (error) {
      return { success: false };
    }
  }
  
 
async function fetchTrainData() {
   const response = await axios.get('http://20.244.56.144/train/trains');
   return response.data; 
}

async function fetchSeatAvailability(trains) {
  
  const availableSeats = {
    return(
        {
            "token_type": "Bearer",
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTIyMDA1NTQsImNvbXBhbnlOYW1lIjoiVHJhaW4gQ2VudHJhbCIsImNsaWVudElEIjoiMzZhNGM3MDgtNGQ0Mi00ZWViLThkMmEtZjI3M2UzZDZjYmUwIiwib3duZXJOYW1lIjoiIiwib3duZXJFbWFpbCI6IiIsInJvbGxObyI6ImQ0MWQ4Y2Q5OGYwMGIyMDRlOTgwMDk5OGVjZjg0MjdlNDIifQ.-JqBOM48TUsZn31W4ZVF-lf7tSn5e8djrQQU_8mLtaM",
            "expires_in": 1692200554
        }
    )
  };

 
  return trains.map(train => ({
    ...train,
    availableSeats: availableSeats[train.id] || 0,
    price: calculatePrice(train.id),
  }));
}

function calculatePrice(trainId) {
 
  return trainId * 10;
}

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
