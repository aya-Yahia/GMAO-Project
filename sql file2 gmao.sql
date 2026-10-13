USE gmao_camions;

-- 1. Populate Equipment List
INSERT INTO Dim_Equipements (code_equipement, designation, famille) VALUES 
('EQ-TRK01-MOT', 'Moteur Diesel Cummins 15L', 'Moteur'),
('EQ-TRK01-FRN', 'Système de Freinage Pneumatique', 'Sécurité/Freins'),
('EQ-TRK02-TRN', 'Boîte de Vitesse Automatique', 'Transmission');

-- 2. Populate Spare Parts Catalog
INSERT INTO Dim_Pieces (code_piece, designation, utilisation, famille_piece, sous_famille_piece, lieu_stockage, reference_constructeur, quantite_en_stock) VALUES 
('P-FLT-88', 'Filtre à carburant', 'Filtration système injection', 'Moteur', 'Filtres', 'Zone A-Rack 2', 'CUMMINS-88F', 40),
('P-BRK-12', 'Plaquette de frein heavy-duty', 'Remplacement plaquettes usées', 'Châssis', 'Freins', 'Zone B-Rack 1', 'BENDIX-B12', 14),
('P-OIL-05', 'Huile Moteur Synthétique 15W40 (1L)', 'Lubrification moteur', 'Moteur', 'Lubrifiants', 'Zone C-Cuve 1', 'SHELL-R4', 120);

-- 3. Simulate a Corrective Breakdown Request (DI)
INSERT INTO Fact_DI (numero_di, titre, etat_di, degre_urgence, famille_di, etat_du_camion, demandeur, code_equipement) VALUES 
('DI-2026-001', 'Perte de puissance et fumée noire', 'À traiter', 'Critique', 'Mécanique', 'Non disponible', 'Chauffeur Ahmed', 'EQ-TRK01-MOT');

-- 4. Simulate a Scheduled Preventive Plan (IP)
INSERT INTO Fact_IP (numero_ip, titre, declencheur, type_work, code_equipement) VALUES 
('IP-2026-M01', 'Contrôle mensuel systématique des freins', 'Chaque 30 jours', 'Contrôle', 'EQ-TRK01-FRN');

-- 5. Create active Work Orders (BT) triggered by the DI and IP
INSERT INTO Fact_BT (numero_bt, numero_di, numero_ip, date_debut_prevue, date_debut_reel, date_fin_prevue, date_fin_reelle, etat_bt, type_work, designation_travaux, degre_urgence, code_equipement) VALUES 
('BT-2026-001', 'DI-2026-001', NULL, '2026-07-05 08:00:00', '2026-07-05 08:30:00', '2026-07-05 12:00:00', '2026-07-05 11:15:00', 'Fait', 'Correctif', 'Changement du filtre bouché', 'Élevé', 'EQ-TRK01-MOT'),
('BT-2026-002', NULL, 'IP-2026-M01', '2026-07-06 09:00:00', '2026-07-06 09:15:00', '2026-07-06 11:00:00', NULL, 'En cours', 'Préventif', 'Mesure usure plaquettes', 'Moyen', 'EQ-TRK01-FRN');

-- 6. Record parts usage
INSERT INTO Fact_Consommation (numero_bt, code_piece, quantite_consommee) VALUES 
('BT-2026-001', 'P-FLT-88', 2),
('BT-2026-001', 'P-OIL-05', 15);