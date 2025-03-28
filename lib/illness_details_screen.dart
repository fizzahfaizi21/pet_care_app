import 'package:flutter/material.dart';
import 'package:petappgroup/pet_utils.dart';

class IllnessDetailsScreen extends StatelessWidget {
  final String illnessName;
  IllnessDetailsScreen({Key? key, required this.illnessName}) : super(key: key);

  final Map<String, Map<String, String>> illnessData = {
    "Upper Respiratory Infection (URI)": {
      "symptoms":
          "• Sneezing, runny nose, watery eyes\n• Coughing, congestion\n• Fever, loss of appetite\n• Lethargy",
      "treatment":
          "Home remedy:\n- Use a humidifier\n- Wipe nasal discharge with a warm cloth\n- Encourage eating (warm food smells better)\n\nVet needed?\nYes, if severe (antibiotics/antivirals may be needed).",
    },
    "Feline Lower Urinary Tract Disease (FLUTD)": {
      "symptoms":
          "• Straining to urinate, crying in litter box\n• Blood in urine\n• Frequent licking of genitals\n• Urinating outside litter box",
      "treatment":
          "Home remedy:\n- Increase water intake (wet food, water fountains)\n- Reduce stress\n\nVet needed?\nURGENT—blockages can be fatal.",
    },
    "Hairballs": {
      "symptoms":
          "• Frequent gagging/coughing\n• Vomiting cylindrical hair clumps\n• Constipation",
      "treatment":
          "Home remedy:\n- Regular brushing\n- Hairball-control food\n- Petroleum-based laxatives (like Laxatone)\n\nVet needed?\nOnly if vomiting persists or cat stops eating.",
    },
    "Fleas & Ticks": {
      "symptoms":
          "• Excessive scratching, biting skin\n• Visible black specks (flea dirt)\n• Hair loss, scabs",
      "treatment":
          "Home remedy:\n- Flea comb\n- Monthly topical/oral preventatives (like Frontline)\n\nVet needed?\nIf severe (anemia, infections).",
    },
    "Worms": {
      "symptoms":
          "• Visible worms in poop/vomit\n• Bloated belly\n• Diarrhea, weight loss",
      "treatment":
          "Home remedy:\n- Over-the-counter dewormers (check with vet first)\n\nVet needed?\nYes, for diagnosis & prescription meds.",
    },
    "Dental Disease": {
      "symptoms":
          "• Bad breath\n• Drooling, difficulty eating\n• Red/swollen gums",
      "treatment":
          "Home remedy:\n- Brush teeth regularly\n- Dental treats\n\nVet needed?\nYes, for professional cleaning/extractions.",
    },
    "Ear Mites": {
      "symptoms":
          "• Dark, waxy ear discharge\n• Scratching ears, head shaking\n• Ear inflammation",
      "treatment":
          "Home remedy:\n- Ear cleaner + vet-prescribed drops\n\nVet needed?\nYes, for proper diagnosis.",
    },
    "Diarrhea": {
      "symptoms": "• Loose/watery stool\n• Lethargy, dehydration",
      "treatment":
          "Home remedy:\n- Fast for 12-24 hrs (water only)\n- Then bland diet (boiled chicken + rice)\n\nVet needed?\nIf diarrhea lasts >2 days or has blood.",
    },
    "Vomiting": {
      "symptoms": "• Throwing up food/bile\n• Lethargy, dehydration",
      "treatment":
          "Home remedy:\n- Small, frequent meals\n- Monitor for hairballs\n\nVet needed?\nIf vomiting is frequent or contains blood.",
    },
    "Obesity": {
      "symptoms": "• Difficulty feeling ribs\n• Low energy, trouble grooming",
      "treatment":
          "Home remedy:\n- Portion control\n- Interactive toys for exercise\n\nVet needed?\nFor a weight-loss diet plan.",
    },
  };

  @override
  Widget build(BuildContext context) {
    // Safe access without ! operator
    final illnessInfo = illnessData[illnessName];

    if (illnessInfo == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Illness information not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(illnessName)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Symptoms Section
              Text(
                "Symptoms",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  illnessInfo['symptoms'] ??
                      'No symptoms information available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),

              // Treatment Section
              Text(
                "Treatment",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  illnessInfo['treatment'] ??
                      'No treatment information available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
