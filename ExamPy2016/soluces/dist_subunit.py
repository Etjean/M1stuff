# define functions
def calc_dist(COM1,COM2):
    x1,y1,z1 = COM1
    x2,y2,z2 = COM2 
    d = (x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2
    d = d**0.5
    return d

def get_COM(liste_coord):
    nb_coor = float(len(liste_coord))
    x = 0.0 ; y = 0.0 ; z = 0.0
    for coor_atom in liste_coord:
        x += coor_atom['x']
        y += coor_atom['y']
        z += coor_atom['z']
    return [x/nb_coor, y/nb_coor, z/nb_coor]
    
def get_coor(pdb_filename, chain_name):
    list_CA= []
    with open(pdb_filename,'r') as f: 
        for line in f:
            line_type = line[0:6].strip()
            name_at = line[12:16].strip()
            chain = line[21:22].strip()
            if line_type == "ATOM" and name_at == "CA" and chain == chain_name:
                name_res = str(line[17:20].strip())
                num_res = int(line[22:26].strip())
                x = float(line[30:38].strip())
                y = float(line[38:46].strip())
                z = float(line[46:54].strip())
                list_CA.append({'numres':num_res,'x':x, 'y':y, 'z':z, 'nameres':name_res})
    return list_CA

################
# main program #
################
# get name of pdb file from command line
pdb_filename = "1gzx.pdb"

# get atom coordinates as a list of dictionnaries
list_coor_A = get_coor(pdb_filename,"A")
list_coor_B = get_coor(pdb_filename,"B")
list_coor_C = get_coor(pdb_filename,"C")
list_coor_D = get_coor(pdb_filename,"D")

COM_A = get_COM(list_coor_A)#; print "COM_A", COM_A
COM_B = get_COM(list_coor_B)#; print "COM_B", COM_B
COM_C = get_COM(list_coor_C)#; print "COM_C", COM_C
COM_D = get_COM(list_coor_D)#; print "COM_D", COM_D

# calc and print distance between each subunit
print "distance chaine A - chaine B = {:6.2f} Ang".format(calc_dist(COM_A, COM_B))
print "distance chaine A - chaine C = {:6.2f} Ang".format(calc_dist(COM_A, COM_C))
print "distance chaine A - chaine D = {:6.2f} Ang".format(calc_dist(COM_A, COM_D))
print "distance chaine B - chaine C = {:6.2f} Ang".format(calc_dist(COM_B, COM_C))
print "distance chaine B - chaine D = {:6.2f} Ang".format(calc_dist(COM_B, COM_D))
print "distance chaine C - chaine D = {:6.2f} Ang".format(calc_dist(COM_C, COM_D))
