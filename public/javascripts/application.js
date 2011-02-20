// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function addCommas(input) {
  output = input.toString();
  var sRegExp = new RegExp('(-?[0-9]+)([0-9]{3})');
  while(sRegExp.test(output)) {
    output = output.replace(sRegExp, '$1,$2');
  }
  return output;
}

var Data = {
  34: {
    name: 'Tritanium',
    volume: 0.01,
    buy: 1.0,
    sell: 3.25
  },
  35: {
    name: 'Pyerite',
    volume: 0.01,
    buy: 3.0,
    sell: 4.97
  },
  36: {
    name: 'Mexallon',
    volume: 0.01,
    buy: 3.0,
    sell: 29.62
  },
  37: {
    name: 'Isogen',
    volume: 0.01,
    buy: 3.0,
    sell: 71.0
  },
  38: {
    name: 'Nocxium',
    volume: 0.01,
    buy: 3.0,
    sell: 600.0
  },
  39: {
    name: 'Zydrine',
    volume: 0.01,
    buy: 1000.0,
    sell: 1190.0
  },
  40: {
    name: 'Megacyte',
    volume: 0.01,
    buy: 3000.0,
    sell: 3347.48
  },

  22: {
    name: 'Arkonor',
    volume: 16.0,
    compress: 20,
    compression: 1000,
    portion_size: 200,
    refine: {
      34: 300,
      39: 166,
      40: 333
    }
  },
  1223: {
    name: 'Bistot',
    volume: 16.0,
    compress: 20,
    compression: 1000,
    portion_size: 200,
    refine: {
      35: 170,
      39: 341,
      40: 170
    }
  },
  1225: {
    name: 'Crokite',
    volume: 16.0,
    compress: 20,
    compression: 1250,
    portion_size: 250,
    refine: {
      34: 331,
      35: 170,
      38: 331,
      39: 663
    }
  },
  1232: {
    name: 'Dark Ochre',
    volume: 8.0,
    compress: 20,
    compression: 2000,
    portion_size: 400,
    refine: {
      34: 250,
      38: 500,
      39: 250
    }
  },
  1229: {
    name: 'Gneiss',
    volume: 5,
    compress: 20,
    compression: 4000,
    portion_size: 400,
    refine: {
      34: 171,
      36: 171,
      37: 343,
      39: 171
    }
  },
  21: {
    name: 'Hedbergite',
    volume: 3,
    compress: 20,
    compression: 5000,
    portion_size: 500,
    refine: {
      37: 708,
      38: 354,
      39:  32
    }
  },
  1231: {
    name: 'Hemorphite',
    volume: 3,
    compress: 20,
    compression: 5000,
    portion_size: 500,
    refine: {
      34: 212,
      37: 212,
      38: 424,
      39:  28,
    }
  },
  1226: {
    name: 'Jaspet',
    volume: 2,
    compress: 20,
    compression: 7500,
    portion_size: 500,
    refine: {
      34: 259,
      35: 259,
      36: 518,
      38: 259,
      39:   8
    }
  },
  20: {
    name: 'Kernite',
    volume: 1.2,
    compress: 20,
    compression: 12000,
    portion_size: 400,
    refine: {
      34: 386,
      36: 773,
      37: 386
    }
  },
  1227: {
    name: 'Omber',
    volume: 0.6,
    compress: 20,
    compression: 25000,
    portion_size: 500,
    refine: {
      34: 307,
      35: 123,
      37: 307
    }
  },
  18: {
    name: 'Plagioclase',
    volume: 0.35,
    compress: 40,
    compression: 33300,
    portion_size: 333,
    refine: {
      34: 256,
      35: 512,
      36: 256
    }
  },
  1224: {
    name: 'Pyroxeres',
    volume: 0.3,
    compress: 40,
    compression: 49950,
    portion_size: 333,
    refine: {
      34: 844,
      35: 59,
      36: 120,
      38: 11
    }
  },
  1228: {
    name: 'Scordite',
    volume: 0.15,
    compress: 40,
    compression: 99900,
    portion_size: 333,
    refine: {
      34: 833,
      35: 416
    }
  },
  19: {
    name: 'Spodumain',
    volume: 16,
    compress: 20,
    compression: 1250,
    portion_size: 250,
    refine: {
      34: 700,
      35: 140,
      40: 140
    }
  },
  1230: {
    name: 'Veldspar',
    volume: 0.1,
    compress: 40,
    compression: 166500,
    portion_size: 333,
    refine: {
      34: 1000
    }
  }
};


function compute() {
  var volume = 0.0;
  var compression_volume = 0.0;
  var compression = 0.0;
  var mineral_units = new Array;

  for (i in Data) {
    var type = Data[i];
    var units = parseInt($('#type_' + i).val());

    if (units > 0) {
      volume += type.volume * units;
      compression_volume += type.volume * units / type.compress;
      compression += units / type.compression * 240;
      
      for (j in type.refine) {
        if (!mineral_units[j]) {
          mineral_units[j] = 0;
        }
        mineral_units[j] += parseInt(units / type.portion_size) * type.refine[j];
      }
    }
  };

  var refining_standard  = volume /  40000 *  3600;
  var refining_medium    = volume /  20000 *  5400;
  var refining_intensive = volume / 200000 * 10800;

  var refine_buy = 0.0;
  var refine_sell = 0.0;
  var refine_volume = 0.0;

  for (i in mineral_units) {
    refine_buy += Data[i].buy * mineral_units[i];
    refine_sell += Data[i].sell * mineral_units[i];
    refine_volume += Data[i].volume * mineral_units[i];
    $('#type_' + i).html(addCommas(mineral_units[i]));
  }

  $('#volume').html(addCommas(volume.toFixed(1)));
  $('#compression_volume').html(addCommas(compression_volume.toFixed(1)));
  $('#compression').html(addCommas(compression.toFixed(2)));
  $('#refining_standard').html(addCommas(refining_standard.toFixed(2)));
  $('#refining_medium').html(addCommas(refining_medium.toFixed(2)));
  $('#refining_intensive').html(addCommas(refining_intensive.toFixed(2)));
  $('#refine_buy').html(addCommas(refine_buy.toFixed(2)));
  $('#refine_sell').html(addCommas(refine_sell.toFixed(2)));
  $('#refine_volume').html(addCommas(refine_volume.toFixed(1)));
}


$(function() {
  $('input[type=submit]').click(function() {
    compute();
    return false;
  });
});
